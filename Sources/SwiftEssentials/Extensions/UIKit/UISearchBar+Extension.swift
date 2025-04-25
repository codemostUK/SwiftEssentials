//
//  UISearchBar+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 10.09.2023.
//

import UIKit

public extension UISearchBar {

    /// A private computed property that creates and configures a `UIActivityIndicatorView`.
    /// - Returns: A configured `UIActivityIndicatorView` instance.
    private var activityIndicator: UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .purple // Custom color for the activity indicator
        indicator.translatesAutoresizingMaskIntoConstraints = true
        indicator.isHidden = false
        return indicator
    }

    /// Displays a loading indicator in the search bar's left view.
    ///
    /// This method replaces the search bar's left view with a `UIActivityIndicatorView` and starts animating it.
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.searchTextField.leftViewMode = .always
            self.searchTextField.leftView = self.activityIndicator
            (self.searchTextField.leftView as? UIActivityIndicatorView)?.startAnimating()
        }
    }

    /// Hides the loading indicator and restores the default magnifying glass icon.
    ///
    /// This method replaces the search bar's left view with a magnifying glass icon.
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.searchTextField.leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
            self.searchTextField.leftView?.tintColor = .purple // Custom color for the magnifying glass icon
        }
    }

    /// A property that allows setting a localized placeholder text.
    ///
    /// The placeholder text is localized using a `localized` method on the new value.
    @IBInspectable var localizedPlaceholderKey: String? {
        get {
            return searchTextField.placeholder
        }
        set {
            searchTextField.placeholder = newValue?.localized ?? ""
            layoutIfNeeded()
        }
    }
}
