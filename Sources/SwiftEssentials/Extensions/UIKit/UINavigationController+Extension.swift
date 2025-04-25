//
//  UINavigationController+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 23.08.2024.
//

import UIKit

public extension UINavigationController {

    /// Sets the navigation bar's transparency.
    ///
    /// This method adjusts the navigation bar's appearance based on the transparency flag.
    /// - Parameter isTransparent: A boolean indicating whether the navigation bar should be transparent.
    func setNavigationBarTransparent(_ isTransparent: Bool) {
        if isTransparent {
            if #available(iOS 15.0, *) {
                navigationController?.navigationBar.scrollEdgeAppearance = nil
            } else {
                navigationBar.setBackgroundImage(UIImage(), for: .default)
                navigationBar.isTranslucent = true
                navigationBar.shadowImage = UIImage()
            }
        } else {
            if #available(iOS 15.0, *) {
                navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
            } else {
                navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: .default), for: .default)
                navigationBar.isTranslucent = UINavigationBar.appearance().isTranslucent
                navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
            }
        }
    }
}
