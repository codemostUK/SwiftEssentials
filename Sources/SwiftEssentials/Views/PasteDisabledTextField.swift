//
//  PasteDisabledTextField.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 11.09.2023.
//

import UIKit

/// A custom `UITextField` subclass that disables the paste action.
/// This can be useful in scenarios where pasting text should not be allowed.
open class PasteDisabledTextField: UITextField {

    /// Overrides the method to disable the paste action for the text field.
    /// - Parameters:
    ///   - action: The action being performed.
    ///   - sender: The object requesting the action.
    /// - Returns: A boolean indicating whether the action is allowed. In this case, paste is disabled.
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
