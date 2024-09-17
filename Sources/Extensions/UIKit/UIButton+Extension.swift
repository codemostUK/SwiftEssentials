//
//  UIButton+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 02.09.2024.
//

import UIKit

public extension UIButton {

    /// A collection of all possible control states that the button can be in.
    private var states: [UIControl.State] {
        [.normal, .selected, .highlighted, .disabled, .focused]
    }

    /// Sets the background image for all control states (`normal`, `selected`, `highlighted`, `disabled`, `focused`).
    /// - Parameter image: The background image to set for the button in all states.
    func setBackgroundImageForAllStates(_ image: UIImage?) {
        states.forEach { setBackgroundImage(image, for: $0) }
    }

    /// Sets the image for all control states (`normal`, `selected`, `highlighted`, `disabled`, `focused`).
    /// - Parameter image: The image to set for the button in all states.
    func setImageForAllStates(_ image: UIImage?) {
        states.forEach { setImage(image, for: $0) }
    }

    /// Sets the title color for all control states (`normal`, `selected`, `highlighted`, `disabled`, `focused`).
    /// - Parameter color: The color to set for the button title in all states.
    func setTitleColorForAllStates(_ color: UIColor?) {
        states.forEach { setTitleColor(color, for: $0) }
    }

    /// Sets the title for all control states (`normal`, `selected`, `highlighted`, `disabled`, `focused`).
    /// - Parameter title: The title to set for the button in all states.
    func setTitleForAllStates(_ title: String) {
        states.forEach { setTitle(title, for: $0) }
    }

    /// Adds an underline to the button title for all relevant states.
    func underline() {
        let states: [UIControl.State] = [.normal, .selected, .highlighted]

        for state in states {
            if let text = self.title(for: state) {
                let attributedString = NSMutableAttributedString(string: text)
                let titleColor = self.titleColor(for: state)

                attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: titleColor!, range: NSRange(location: 0, length: text.count))
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: titleColor!, range: NSRange(location: 0, length: text.count))
                attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
                self.setAttributedTitle(attributedString, for: state)
            }
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var isActive: Bool {
        get {
            return isUserInteractionEnabled
        }
        set {
            isUserInteractionEnabled = newValue
            alpha = newValue ? 1.0 : 0.5
        }
    }

    @IBInspectable var localizedKey: String? {
        get {
            return title(for: .normal)
        }
        set {
            let localizedTitle = newValue?.localized ?? ""
            setTitle(localizedTitle, for: .normal)
            setTitle(localizedTitle, for: .selected)
            setTitle(localizedTitle, for: .highlighted)
        }
    }
}
