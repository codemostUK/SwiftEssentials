//
//  UILabel+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.08.2024.
//

import Foundation
import UIKit

public extension UILabel {

    /// A property that allows setting an HTML string localized using `NSLocalizedString`.
    ///
    /// This property takes the localization key, retrieves the localized string, and converts it into an attributed HTML string.
    @IBInspectable var htmlLocalizedKey: String? {
        get {
            return attributedText?.string
        }
        set {
            setAttributedString(string: NSLocalizedString(newValue ?? "", comment: ""))
        }
    }

    /// A property that allows setting a localized text for the label.
    ///
    /// This property uses `NSLocalizedString` to set the text of the label.
    @IBInspectable var localizedKey: String? {
        get {
            return text
        }
        set {
            text = NSLocalizedString(newValue ?? "", comment: "")
        }
    }

    /// Sets the attributed text of the label by parsing the input HTML string.
    /// - Parameters:
    ///   - string: The HTML string to be rendered as attributed text.
    ///   - forceColor: An optional color to override the text color in the HTML.
    func setAttributedString(string: String, forceColor: UIColor? = nil) {
        Task { @MainActor in
            // Convert the input string into data for parsing.
            guard let data = string.data(using: .unicode) else { return }
            do {
                // Parse the HTML data into an attributed string.
                let mutableAttributedString = try NSMutableAttributedString(data: data,
                    options: [.documentType: NSAttributedString.DocumentType.html,
                              .characterEncoding: NSUnicodeStringEncoding],
                    documentAttributes: nil)

                // If a forceColor is provided, apply it to the entire string.
                if let forceColor {
                    mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: forceColor, range: NSRange(location: 0, length: mutableAttributedString.length))
                }

                // Set the attributed text on the label.
                self.attributedText = mutableAttributedString
            } catch {
                // Handle any errors in converting the string to attributed text.
            }
        }
    }
}
