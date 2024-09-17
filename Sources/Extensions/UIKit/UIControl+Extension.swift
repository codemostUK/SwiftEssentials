//
//  UIControl+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 19.11.2023.
//

import Foundation
import UIKit

/// Extension for UIResponder to provide a unique identifier for each UI element.
public extension UIResponder {

    /// Returns the class name of the object as a string, which can be used as a unique identifier for UI elements.
    /// - Example: For a `UIButton`, it returns `"UIButton"`.
    static var identifier: String {
        return String(describing: self)
    }
}
