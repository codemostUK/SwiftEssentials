//
//  UIApplication+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 08.03.2024.
//

import UIKit
import MessageUI
import Foundation

public extension UIApplication {

    /// Retrieves the root window of the application.
    /// - Returns: The root window of the application, if available.
    static var rootWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            // On iOS 13.0+, use connected scenes to find the first window scene.
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                return scene.windows.first
            }

            // Fallback to checking all windows.
            for window in UIApplication.shared.windows {
                if window.isKeyWindow {
                    return window
                }
            }
            return nil
        } else {
            // Pre-iOS 13.0, return the key window directly.
            return UIApplication.shared.keyWindow
        }
    }

    /// Checks if a specific app (AppKind) can be opened on the device.
    /// - Parameter appKind: The type of app to check.
    /// - Returns: `true` if the app can be opened, otherwise `false`.
    static func canOpen(_ appKind: AppKind) -> Bool {
        if appKind == .appleMaps { return true } // Apple Maps is always available.
        if let URL = URL(string: appKind.URL) {
            return UIApplication.shared.canOpenURL(URL)
        } else {
            return false
        }
    }

    /// Enum representing different types of apps that can be checked for availability.
    enum AppKind {
        case appleMaps
        case googleMaps
        case appleMail
        case gmail
        case msOutlook
        case instagram
        case googleChromes
        case whatsapp
        case yandexMap
        case yandexNavi

        /// The URL scheme for each app, used to check if the app is available.
        var URL: String {
            switch self {
            case .appleMaps:
                return ""
            case .googleMaps:
                return "comgooglemaps://"
            case .appleMail:
                return "mailto://"
            case .gmail:
                return "googlegmail://"
            case .msOutlook:
                return "ms-outlook://"
            case .instagram:
                return "instagram://"
            case .googleChromes:
                return "googlechrome://"
            case .whatsapp:
                return "whatsapp://"
            case .yandexMap:
                return "yandexmaps://"
            case .yandexNavi:
                return "yandexnavi://"
            }
        }
    }

    /// Retrieves the current version and build number of the app.
    /// - Returns: A string containing the version and build number in the format "v x.x - b xxxx".
    static var versionAndBuild: String {
        if
            let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString"),
            let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")
        {
            return ("v \(version) - b \(build) ")
        }
        return ""
    }

    /// Searches for available map apps (Apple Maps, Google Maps, etc.) and presents an action sheet allowing the user to search a location.
    /// - Parameter text: The location to search for.
    static func searchAvailableMapAppsFor(_ text: String?) {
        guard
            let text,
            let encoded = text.addingPercentEncoding(withAllowedCharacters: .alphanumerics),
            let appleUrl = URL(string: "https://maps.apple.com/?q=\(encoded)"),
            let googleUrl = URL(string: "https://www.google.com/maps/search/?api=1&query=\(encoded)")
        else { return }

        // Action sheet title with the search text.
        let title = String(format: NSLocalizedString("%@ için arama yap", comment: "Search for something"), text)

        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        alert.view.tintColor = .init(named: "AccentColor")!

        // Option to search in Apple Maps.
        alert.addAction(UIAlertAction(title: NSLocalizedString("Apple Haritalar", comment: ""), style: .default, handler: { _ in
            UIApplication.shared.open(appleUrl)
        }))

        // Option to search in Google Maps, if available.
        if UIApplication.canOpen(.googleMaps) {
            alert.addAction(UIAlertAction(title: NSLocalizedString("Google Haritalar", comment: ""), style: .default, handler: { _ in
                UIApplication.shared.open(googleUrl)
            }))
        }

        alert.addAction(UIAlertAction(title: NSLocalizedString("İptal", comment: "Cancel"), style: .cancel))

        // Ensure the action sheet is presented correctly on all devices.
        guard let topVC = UIViewController.topMostVC() else { return }
        if UIDevice.current.userInterfaceIdiom != .phone {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = topVC.view
                popoverController.sourceRect = CGRect(x: topVC.view.bounds.midX, y: topVC.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
        }

        topVC.present(alert, animated: true)
    }

    /// Sends an email using Apple Mail.
    /// - Parameters:
    ///   - to: The recipient email address.
    ///   - subject: The email subject.
    ///   - body: The email body.
    ///   - delegate: The delegate to handle the email result.
    ///   - presentingViewController: The view controller to present the mail compose screen.
    static func sendAppleMail(to: String, subject: String, body: String, delegate: MFMailComposeViewControllerDelegate?, presentingViewController: UIViewController) {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = delegate
            composeVC.setToRecipients([to])
            composeVC.setSubject(subject)
            composeVC.setMessageBody(body, isHTML: false)
            presentingViewController.present(composeVC, animated: true, completion: nil)
        }
    }

    /// Sends an email using Gmail.
    /// - Parameters:
    ///   - to: The recipient email address.
    ///   - subject: The email subject.
    ///   - body: The email body.
    static func sendGoogleMail(to: String, subject: String, body: String) {
        let customURL = "googlegmail:///co?to=\(to)&subject=\(subject)&body=\(body)"
        guard let encodedString = customURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
              let gmailURL = URL(string: encodedString) else { return }

        if canOpen(.gmail) {
            goto(gmailURL)
        } else {
            print("Cannot open Gmail.")
        }
    }

    /// Shows an action sheet to select an email client (Apple Mail or Gmail) and sends an email using the selected client.
    /// - Parameters:
    ///   - to: The recipient email address.
    ///   - subject: The email subject.
    ///   - body: The email body.
    ///   - delegate: The delegate to handle the result of sending the email.
    ///   - presentingViewController: The view controller to present the email client selection.
    static func showMailAlertSelectionSheetFor(to: String, subject: String, body: String, delegate: MFMailComposeViewControllerDelegate?, presentingViewController: UIViewController) {
        let alert = UIAlertController(title: NSLocalizedString("Bir e-posta uygulaması seç", comment: "Choose an email app"), message: nil, preferredStyle: .actionSheet)
        alert.view.tintColor = .init(named: "AccentColor")!

        // Apple Mail option.
        alert.addAction(UIAlertAction(title: NSLocalizedString("Apple Mail", comment: ""), style: .default, handler: { _ in
            UIApplication.sendAppleMail(to: to, subject: subject, body: body, delegate: delegate, presentingViewController: presentingViewController)
        }))

        // Gmail option.
        alert.addAction(UIAlertAction(title: NSLocalizedString("Gmail", comment: ""), style: .default, handler: { _ in
            UIApplication.sendGoogleMail(to: to, subject: subject, body: body)
        }))

        alert.addAction(UIAlertAction(title: NSLocalizedString("İptal", comment: "Cancel"), style: .cancel))

        // Ensure proper display of the alert on non-iPhone devices.
        if UIDevice.current.userInterfaceIdiom != .phone {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = presentingViewController.view
                popoverController.sourceRect = CGRect(x: presentingViewController.view.bounds.midX, y: presentingViewController.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
        }

        presentingViewController.present(alert, animated: true, completion: nil)
    }

    /// Sends an email via either Apple Mail or Gmail, depending on availability.
    /// - Parameters:
    ///   - to: The recipient email address.
    ///   - subject: The email subject.
    ///   - body: The email body.
    ///   - delegate: The delegate to handle the result of sending the email.
    ///   - presentingViewController: The view controller to present the email client selection.
    static func sendSupportEmail(to: String,
                                 subject: String,
                                 body: String,
                                 delegate: MFMailComposeViewControllerDelegate?,
                                 presentingViewController: UIViewController) {
        // If both Apple Mail and Gmail are available, show a selection sheet.
        if canOpen(.appleMail) && canOpen(.gmail) {
            UIApplication.showMailAlertSelectionSheetFor(to: to, subject: subject, body: body, delegate: delegate, presentingViewController: presentingViewController)
        }
        // If only Apple Mail is available, send via Apple Mail.
        else if canOpen(.appleMail) {
            UIApplication.sendAppleMail(to: to, subject: subject, body: body, delegate: delegate, presentingViewController: presentingViewController)
        }
        // If only Gmail is available, send via Gmail.
        else if canOpen(.gmail) {
            UIApplication.sendGoogleMail(to: to, subject: subject, body: body)
        }
    }

    /// The bottom safe area inset of the root window.
     /// - Returns: The bottom safe area inset of the root window, or `0` if the root window is unavailable.
     static var safeAreaBottom: CGFloat {
         return rootWindow?.safeAreaInsets.bottom ?? 0
     }

     /// Retrieves the topmost view controller in the application's view hierarchy.
     /// - Parameter controller: The starting view controller to search from. Defaults to the root view controller of the root window.
     /// - Returns: The topmost view controller, or `nil` if no view controller is found.
     class func topViewController(_ controller: UIViewController? = UIApplication.rootWindow?.rootViewController) -> UIViewController? {
         if let navigationController = controller as? UINavigationController {
             return topViewController(navigationController.visibleViewController)
         }

         if let tabController = controller as? UITabBarController {
             if let selected = tabController.selectedViewController {
                 return topViewController(selected)
             }
         }

         if let presented = controller?.presentedViewController {
             return topViewController(presented)
         }

         return controller
     }
}
