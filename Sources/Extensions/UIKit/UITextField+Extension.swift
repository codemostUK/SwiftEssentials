//
//  UITextField+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 08.07.2024.
//

import UIKit

extension UITextField {

    /// Sets up a button to toggle the visibility of the password text.
    ///
    /// - Parameter image: The image to display on the button.
    func setupPasswordButton(_ image: UIImage?) {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(self.showPasswordTapped), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }

    /// Toggles the secure text entry mode for password visibility.
    @IBAction func showPasswordTapped(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
    }

    /// A property that allows setting a localized placeholder text.
    ///
    /// This property uses a `localized` method to set the placeholder text of the text field.
    @IBInspectable var localizedPlaceholderKey: String? {
        get {
            return placeholder
        }
        set {
            placeholder = newValue?.localized ?? ""
            layoutIfNeeded()
        }
    }
}
