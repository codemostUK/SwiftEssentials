//
//  UIScreen+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 10.09.2023.
//

import UIKit

public extension UIScreen {

    /// Returns the width of the screen.
    /// - Returns: The width of the screen.
    static var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    /// Returns the height of the screen.
    /// - Returns: The height of the screen.
    static var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
}
