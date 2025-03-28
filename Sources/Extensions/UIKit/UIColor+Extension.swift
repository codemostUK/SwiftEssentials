//
//  UIColor+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 12.07.2023.
//

import UIKit

public extension UIColor {

    /// Initializes a `UIColor` object using a hex string and an optional alpha value.
    /// - Parameters:
    ///   - hex: The hex string representing the color (e.g., "#FF5733" or "FF5733").
    ///   - alpha: The alpha value of the color (default is 1.0, fully opaque).
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        // Remove the '#' prefix if it exists.
        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }

        let scanner = Scanner(string: hexString)

        var color: UInt64 = 0
        scanner.scanHexInt64(&color) // Scan the hex string into a UInt64.
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask // Extract the red component.
        let g = Int(color >> 8) & mask  // Extract the green component.
        let b = Int(color) & mask       // Extract the blue component.

        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /// Converts the `UIColor` object to its hex string representation.
    /// - Returns: A string in the format "#RRGGBB" representing the color.
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        // Extract the RGBA components of the color.
        getRed(&r, green: &g, blue: &b, alpha: &a)

        // Convert the red, green, and blue components to integers and format as a hex string.
        let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
        return String(format: "#%06x", rgb)
    }

    /// Adjusts the brightness of the color by a given factor.
    /// - Parameter factor: A multiplier for brightness; values > 1.0 increase brightness, values < 1.0 decrease it.
    /// - Returns: A new `UIColor` instance with adjusted brightness, or the original color if components cannot be extracted.
    func adjustBrightness(by factor: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return self // Return the original color if components can't be extracted
        }

        return UIColor(
            red: min(max(0, red * factor), 1),
            green: min(max(0, green * factor), 1),
            blue: min(max(0, blue * factor), 1),
            alpha: alpha
        )
    }

    /// Returns a color that is 20% darker.
    func darker() -> UIColor {
        return adjustBrightness(by: 0.8)
    }
    /// Returns a color that is 40% darker.
    func darkerMore() -> UIColor {
        return adjustBrightness(by: 0.6)
    }

    /// Returns a color that is 20% lighter.
    func lighter() -> UIColor {
        return adjustBrightness(by: 1.2)
    }
    /// Returns a color that is 40% lighter.
    func lighterMore() -> UIColor {
        return adjustBrightness(by: 1.4)
    }
}
