//
//  UITextView+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 12.07.2024.
//

import UIKit

public extension UITextView {

    /// Sets highlighted text for URLs within the text view.
    ///
    /// This method identifies URLs in the given text and applies specified attributes (color, font) to them.
    /// It also disables editing and enables link detection.
    /// - Parameters:
    ///   - text: The text to display in the text view, containing URLs.
    ///   - highlightColor: The color to highlight the URLs. Defaults to red if not provided.
    ///   - font: The font to use for the text. Defaults to the current font of the text view if not provided.
    func setUrlHighlightedText(text: String, highlightColor: UIColor?, font: UIFont? = nil) {
        let attributedString = NSMutableAttributedString(string: text, attributes: [.font: font ?? self.font ?? UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.label])
        let linkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: highlightColor ?? .red,
            .underlineColor: highlightColor ?? .red,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]

        self.linkTextAttributes = linkAttributes
        let pattern = "(www|http:|https:)+[^\\s]+[\\w]"
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(text.startIndex..<text.endIndex, in: text)

        regex.enumerateMatches(in: text, options: [], range: range) { match, _, _ in
            if let matchRange = match?.range {
                attributedString.addAttributes(linkAttributes, range: matchRange)
            }
        }

        self.attributedText = attributedString
        self.isEditable = false
        self.dataDetectorTypes = .link
    }

    /// Adds a toolbar with a Done button to the keyboard.
    ///
    /// This method adds a toolbar with a Done button above the keyboard, which dismisses the keyboard when tapped.
    func addKeyboardDoneButton() {
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.donePressed))

        keyboardToolBar.setItems([flexibleSpace, doneButton], animated: true)

        self.inputAccessoryView = keyboardToolBar
    }

    /// Dismisses the keyboard when the Done button is tapped.
    @objc private func donePressed() {
        self.resignFirstResponder()
    }

    /// Sets the text view's content from an HTML-formatted string.
    ///
    /// This method attempts to convert a given HTML string into an attributed string
    /// and applies default styling (font, color, paragraph style).
    /// If the conversion fails, it falls back to setting plain text.
    /// - Parameter htmlString: A string containing HTML content to render.
    func setHTMLFromString(_ htmlString: String) {
        guard let data = htmlString.data(using: .utf8) else {
            self.text = htmlString
            return
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        if let attributedString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byWordWrapping
            paragraphStyle.alignment = .left

            attributedString.addAttributes([
                .foregroundColor: UIColor.label,
                .font: UIFont.systemFont(ofSize: 14),
                .paragraphStyle: paragraphStyle
            ], range: NSRange(location: 0, length: attributedString.length))

            self.attributedText = attributedString
            self.linkTextAttributes = [
                .foregroundColor: UIColor.systemBlue,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        } else {
            self.text = htmlString
        }
    }
}
