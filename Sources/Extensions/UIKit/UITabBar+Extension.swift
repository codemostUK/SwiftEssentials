//
//  UITabBar+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 15.08.2024.
//

import UIKit

public extension UITabBar {

    /// Configures the badge font and background color for tab bar items.
    ///
    /// This method sets the badge's background color and font for tab bar items.
    /// It only applies to iOS 15 and later, using `UITabBarAppearance` and `UITabBarItemAppearance`.
    func setBadgeFont() {
        if #available(iOS 15, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()

            let tabBarItemAppearance = UITabBarItemAppearance()

            // Set the badge background color
            tabBarItemAppearance.normal.badgeBackgroundColor = .red

            // Set the badge font and size
            tabBarItemAppearance.normal.badgeTextAttributes = [
                .font: UIFont.systemFont(ofSize: 13)
            ]

            tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance

            standardAppearance = tabBarAppearance
            scrollEdgeAppearance = tabBarAppearance
        }
    }
}
