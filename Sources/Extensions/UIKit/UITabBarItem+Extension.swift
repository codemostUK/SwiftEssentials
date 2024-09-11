//
//  UITabBarItem+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 13.08.2024.
//

import UIKit

extension UITabBarItem {

    /// A property that allows setting a localized title for the tab bar item.
    ///
    /// This property uses a `localized` method to set the title of the tab bar item.
    @IBInspectable var localizedKey: String? {
        get {
            return title
        }
        set {
            title = newValue?.localized ?? ""
        }
    }

    /// Configures the tab bar item appearance for iOS 15 and later.
    ///
    /// This method sets the tab bar appearance to use an opaque background.
    func setTabBarUI() {
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            standardAppearance = appearance
            scrollEdgeAppearance = appearance
        }
    }
}
