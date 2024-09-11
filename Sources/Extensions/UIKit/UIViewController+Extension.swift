//
//  UIViewController+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 19.09.2024.
//

import Foundation
import UIKit

public extension UIViewController {

    /// Adds a gesture recognizer to hide the keyboard when tapping around the view.
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    /// Dismisses the keyboard when called.
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    /// Returns the top-most view controller presented by the current view controller.
    ///
    /// - Returns: The top-most view controller or `nil` if none is found.
    var presentedVC: UIViewController? {
        guard let presentedViewController = presentedViewController else { return nil }

        if let nc = presentedViewController as? UINavigationController {
            return nc.topViewController
        } else {
            return presentedViewController
        }
    }

    /// Returns the top-most view controller presented by the current view controller.
    ///
    /// - Returns: The top-most view controller or `nil` if none is found.
    var presentingTopVC: UIViewController? {
        guard let presentingViewController = presentingViewController else { return nil }

        if let nc = presentingViewController as? UINavigationController {
            return nc.topViewController
        } else if let tc = presentingViewController as? UITabBarController {
            if let selectedNC = tc.selectedViewController as? UINavigationController {
                return selectedNC.topViewController
            } else {
                return nil
            }
        } else {
            return presentingViewController
        }
    }

    /// Presents an alert controller with optional title, message, and actions.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    ///   - cancelButtonTitle: The title of the cancel button.
    ///   - cancelHandler: The handler for the cancel action.
    ///   - confirmButtonTitle: The title of the confirm button.
    ///   - confirmHandler: The handler for the confirm action.
    ///   - confirmStyle: The style of the confirm button.
    func showAlert(
        title: String? = nil,
        message: String? = nil,
        cancelButtonTitle: String? = nil,
        cancelHandler: ((UIAlertAction) -> Void)? = nil,
        confirmButtonTitle: String? = nil,
        confirmHandler: ((UIAlertAction) -> Void)? = nil,
        confirmStyle: UIAlertAction.Style? = .default
    ) {
        Task {
            @MainActor in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            if let confirmButtonTitle = confirmButtonTitle {
                let confirmAction = UIAlertAction(title: confirmButtonTitle, style: confirmStyle ?? .default, handler: confirmHandler)
                alert.addAction(confirmAction)
            }

            if let cancelButtonTitle = cancelButtonTitle {
                let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .default, handler: cancelHandler)
                alert.addAction(cancelAction)
            }

            if UIDevice.current.userInterfaceIdiom != .phone {
                if let popoverController = alert.popoverPresentationController {
                    popoverController.sourceView = self.view
                    popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                    popoverController.permittedArrowDirections = []
                }
            }
            self.present(alert, animated: true)
        }
    }

    /// Shares the provided file using a UIActivityViewController.
    ///
    /// - Parameter file: The file to share.
    func share(_ file: AnyObject) {
        let filesToShare = [ file ]
        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }

    /// Returns the top-most view controller from the application's root window.
    ///
    /// - Returns: The top-most view controller or `nil` if none is found.
    static func topMostVC() -> UIViewController? {
        return UIApplication.rootWindow?.rootViewController?.topMostViewController()
    }

    private func topMostViewController() -> UIViewController {
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        } else {
            for view in self.view.subviews {
                if let subViewController = view.next {
                    if subViewController is UIViewController {
                        let viewController = subViewController as! UIViewController
                        return viewController.topMostViewController()
                    }
                }
            }
            return self
        }
    }
}
