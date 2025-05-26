//
//  Int+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import Foundation

public extension Int {

    /// Returns the integer formatted as a localized string with decimal separators in the Turkish locale.
    var formattedString: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(integerLiteral: self))!
    }

    /// Converts the integer to a string.
    var toString: String {
        return String("\(self)")
    }

    /// Returns the integer as a string, but shows a dash ("-") if the value is zero or negative.
    var toStringWithDashForZero: String {
        if self > 0 {
            return "\(self)"
        } else {
            return "-"
        }
    }

    /// Converts the integer (assumed to be a Unix timestamp) to a `Date` object.
    var toDate: Date? {
        let interval = TimeInterval(self)
        return Date(timeIntervalSince1970: interval)
    }

    /// Returns the integer abbreviated as a string (e.g., 1,000 as "1B", 1,000,000 as "1Mn").
    var abbreviatedString: String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        var formatted = ""

        switch num {
            case 1_000_000_000_000...:
                let value = (num / 1_000_000_000_000).reduceScale(to: 1)
                formatted = value.truncatingRemainder(dividingBy: 1) == 0
                ? "\(Int(value))Tr"
                : "\(String(format: "%.1f", value))Tr"

            case 1_000_000_000...:
                let value = (num / 1_000_000_000).reduceScale(to: 1)
                formatted = value.truncatingRemainder(dividingBy: 1) == 0
                ? "\(Int(value))Mr"
                : "\(String(format: "%.1f", value))Mr"

            case 1_000_000...:
                let value = (num / 1_000_000).reduceScale(to: 1)
                formatted = value.truncatingRemainder(dividingBy: 1) == 0
                ? "\(Int(value))Mn"
                : "\(String(format: "%.1f", value))Mn"

            case 1_000...:
                let value = (num / 1_000).reduceScale(to: 1)
                formatted = value.truncatingRemainder(dividingBy: 1) == 0
                ? "\(Int(value))B"
                : "\(String(format: "%.1f", value))B"

            case 0...:
                formatted = "\(num)"

            default:
                formatted = "\(sign)\(num)"
        }

        return "\(sign)\(formatted)"
    }

    /// Converts the integer from degrees to radians.
    var radian: CGFloat {
        return Double(self) * Double.pi / 180.0
    }
}
