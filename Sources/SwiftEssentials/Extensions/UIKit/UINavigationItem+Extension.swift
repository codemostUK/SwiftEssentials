//
//  UINavigationItem+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 11.05.2024.
//

import Foundation
import UIKit

public extension UINavigationItem {

    /// A custom property to localize the title of the navigation item using `NSLocalizedString`.
    /// - This property allows you to set a localization key, and the corresponding localized string will be applied as the title of the navigation bar.
    @IBInspectable var localizedKey: String? {
        get {
            return title
        }
        set {
            title = NSLocalizedString(newValue ?? "", comment: "")
        }
    }
}
