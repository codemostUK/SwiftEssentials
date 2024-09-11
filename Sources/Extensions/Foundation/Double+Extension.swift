//
//  Double+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import Foundation

public extension Double {

    /// Returns the double value formatted as a string with up to 2 decimal places.
    var formattedString: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = "."
        return formatter.string(from: NSNumber(floatLiteral: self))!
    }

    /// Returns the double value formatted as a currency string in the Turkish locale ("tr_TR").
    var formattedStringCurrency: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(floatLiteral: self))!
    }

    /// Converts the double to a `Decimal` value.
    var decimalValue: Decimal {
        return NSNumber(floatLiteral: self).decimalValue
    }

    /// Reduces the number of decimal places in the double to the specified value.
    /// - Parameter places: The number of decimal places to keep.
    /// - Returns: The double value truncated to the specified number of decimal places.
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }

    /// Converts the double to a string.
    var toString: String {
        return String("\(self)")
    }

    /// Returns the double as a string, but shows a dash ("-") if the value is zero or negative.
    var toStringWithDashForZero: String {
        if self > 0 {
            return "\(self)"
        } else {
            return "-"
        }
    }

    /// Converts the double to an integer.
    var toInt: Int {
        return Int(self)
    }
}
