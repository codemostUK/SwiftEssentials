//
//  String+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import Foundation
import UIKit

public extension String {

    /// Returns the localized version of the string.
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    /// Converts the string to uppercase using Turkish locale-specific casing rules.
    var upperTR: String {
        return self.uppercased(with: Locale.init(identifier: "TR-tr"))
    }

    /// Replaces all occurrences of backslash-n (`\n`) in the string with a newline character (`\n`).
    /// - Returns: The modified string with normalized newlines.
    func normalizeBackslash() -> String {
        return self.replacingOccurrences(of: "\\n", with: "\n")
    }

    /// Converts the string into a regular expression pattern where "i", "I", "ı", and "İ" are treated as interchangeable.
    /// - Returns: A regex pattern string if successful.
    var needleConvertedToRegexPattern: String? {
        var fixedString: String = String()
        self.enumerated().forEach { (index, element) in
            var letter: String  = String(element)
            if element == "ı" || element == "i" || element == "İ" {
                letter = "[ıiIİ]"
            }
            fixedString.append(letter)
        }
        return String(".*\(fixedString).*")
    }

    /// Converts the string (assumed to be in JSON format) into a dictionary.
    /// - Returns: A dictionary of `[AnyHashable:AnyObject]` if the conversion is successful, otherwise `nil`.
    var dictionary: [AnyHashable: AnyObject]? {
        guard let data = self.data(using: .utf8) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [AnyHashable: AnyObject] else { return nil }
        return dictionary
    }

    /// Converts the string into a `UIColor`. Assumes the string represents a hex color code.
    /// - Returns: A `UIColor` created from the hex string, or gray if the string is invalid.
    var color: UIColor {
        var cString: String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if cString.count != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    /// Calculates the height of the string when constrained to a specified width and font.
    /// - Parameters:
    ///   - width: The maximum width for the string.
    ///   - font: The font used to render the string.
    /// - Returns: The height required to display the string within the specified width.
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading],
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)

        return ceil(boundingBox.height)
    }

    /// Calculates the width of the string when constrained to a specified height and font.
    /// - Parameters:
    ///   - height: The maximum height for the string.
    ///   - font: The font used to render the string.
    /// - Returns: The width required to display the string within the specified height.
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {

        let maximumLabelSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)

        let textRect = self.boundingRect(with: maximumLabelSize,
                                         options: [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading],
                                         attributes: [.font : font],
                                         context: nil)
        return ceil(textRect.size.width)
    }

    fileprivate static let ANYONE_CHAR_UPPER = "X"
    fileprivate static let ONLY_CHAR_UPPER = "C"
    fileprivate static let ONLY_NUMBER_UPPER = "N"
    fileprivate static let ANYONE_CHAR = "x"
    fileprivate static let ONLY_CHAR = "c"
    fileprivate static let ONLY_NUMBER = "n"

    /// Formats the string according to the provided format and old string.
    /// - Parameters:
    ///   - format: The format string.
    ///   - oldString: The old string used for formatting.
    /// - Returns: The formatted string.
    func format(_ format: String, oldString: String) -> String {
        let stringUnformated = self.unformat(format, oldString: oldString)
        var newString = String()
        var counter = 0
        if stringUnformated.count == counter {
            return newString
        }
        for i in 0..<format.count {
            var stringToAdd = ""
            let unicharFormatString = format[i]
            let charFormatString = unicharFormatString
            let charFormatStringUpper = unicharFormatString.uppercased()
            let unicharString = stringUnformated[counter]
            let charString = unicharString
            let charStringUpper = unicharString.uppercased()
            if charFormatString == String.ANYONE_CHAR {
                stringToAdd = charString
                counter += 1
            } else if charFormatString == String.ANYONE_CHAR_UPPER {
                stringToAdd = charStringUpper
                counter += 1
            } else if charFormatString == String.ONLY_CHAR_UPPER {
                counter += 1
                if charStringUpper.isChar() {
                    stringToAdd = charStringUpper
                }
            } else if charFormatString == String.ONLY_CHAR {
                counter += 1
                if charString.isChar() {
                    stringToAdd = charString
                }
            } else if charFormatStringUpper == String.ONLY_NUMBER_UPPER {
                counter += 1
                if charString.isNumber() {
                    stringToAdd = charString
                }
            } else {
                stringToAdd = charFormatString
            }

            newString += stringToAdd
            if counter == stringUnformated.count {
                if i == format.count - 2 {
                    let lastUnicharFormatString = format[i + 1]
                    let lastCharFormatStringUpper = lastUnicharFormatString.uppercased()
                    let lasrCharControl = (!(lastCharFormatStringUpper == String.ONLY_CHAR_UPPER) &&
                                           !(lastCharFormatStringUpper == String.ONLY_NUMBER_UPPER) &&
                                           !(lastCharFormatStringUpper == String.ANYONE_CHAR_UPPER))
                    if lasrCharControl {
                        newString += lastUnicharFormatString
                    }
                }
                break
            }
        }
        return newString
    }

    /// Unformats the string according to the provided format and old string.
    /// - Parameters:
    ///   - format: The format string.
    ///   - oldString: The old string used for unformatting.
    /// - Returns: The unformatted string.
    func unformat(_ format: String, oldString: String) -> String {
        var string: String = self
        var undefineChars = [String]()
        for i in 0..<format.count {
            let unicharFormatString = format[i]
            let charFormatString = unicharFormatString
            let charFormatStringUpper = unicharFormatString.uppercased()
            if !(charFormatStringUpper == String.ANYONE_CHAR_UPPER) &&
                !(charFormatStringUpper == String.ONLY_CHAR_UPPER) &&
                !(charFormatStringUpper == String.ONLY_NUMBER_UPPER) {
                var control = false
                for i in 0..<undefineChars.count {
                    if undefineChars[i] == charFormatString {
                        control = true
                    }
                }
                if !control {
                    undefineChars.append(charFormatString)
                }
            }
        }
        if oldString.count - 1 == string.count {
            var changeCharIndex = 0
            for i in 0..<string.count {
                let unicharString = string[i]
                let charString = unicharString
                let unicharString2 = oldString[i]
                let charString2 = unicharString2
                if charString != charString2 {
                    changeCharIndex = i
                    break
                }
            }
            let changedUnicharString = oldString[changeCharIndex]
            let changedCharString = changedUnicharString
            var control = false
            for i in 0..<undefineChars.count {
                if changedCharString == undefineChars[i] {
                    control = true
                    break
                }
            }
            if control {
                var i = changeCharIndex - 1
                while i >= 0 {
                    let findUnicharString = oldString[i]
                    let findCharString = findUnicharString
                    var control2 = false
                    for j in 0..<undefineChars.count {
                        if findCharString == undefineChars[j] {
                            control2 = true
                            break
                        }
                    }
                    if !control2 {
                        string = (oldString as NSString).replacingCharacters(in: NSRange(location: i, length: 1), with: "")
                        break
                    }
                    i -= 1
                }
            }
        }
        for i in 0..<undefineChars.count {
            string = string.replacingOccurrences(of: undefineChars[i], with: "")
        }
        return string
    }

    /// Checks if the string contains only alphabetical characters including Turkish characters.
    /// - Returns: `true` if the string contains only alphabetical characters, otherwise `false`.
    fileprivate func isChar() -> Bool {
        return regexControlString(pattern: "[a-zA-ZğüşöçıİĞÜŞÖÇ]")
    }

    /// Checks if the string contains only numeric characters.
    /// - Returns: `true` if the string contains only numeric characters, otherwise `false`.
    fileprivate func isNumber() -> Bool {
        return regexControlString(pattern: "^[0-9]*$")
    }

    /// Checks if the string matches the given regular expression pattern.
    /// - Parameter pattern: The regular expression pattern to match.
    /// - Returns: `true` if the string matches the pattern, otherwise `false`.
    fileprivate func regexControlString(pattern: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let numberOfMatches = regex.numberOfMatches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            return numberOfMatches == self.count
        } catch {
            return false
        }
    }

    /// Subscript to access a single character at a specific index.
    /// - Parameter i: The index of the character to access.
    /// - Returns: The character at the specified index.
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    /// Subscript to access a substring within a specified range.
    /// - Parameter r: The range of indices for the substring.
    /// - Returns: The substring within the specified range.
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                            upper: min(count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        let rangeLast: Range<Index> = start..<end
        return String(self[rangeLast])
    }

    /// Retrieves a configuration value from the app's Info.plist.
    /// - Returns: The configuration value as a `String`, or `nil` if not found.
    var configValue: String? {
        return (Bundle.main.infoDictionary?[self] as? String)?.replacingOccurrences(of: "\\", with: "")
    }

    /// Compares the current string version with another version string.
    /// - Parameter otherVersion: The version string to compare against.
    /// - Returns: The result of the comparison as `ComparisonResult`.
    func versionCompare(_ otherVersion: String) -> ComparisonResult {
        return self.compare(otherVersion, options: .numeric)
    }

    // MARK: - Validation

    /// Checks if the string contains only numeric characters.
    /// - Returns: `true` if the string is numeric, otherwise `false`.
    var isNumeric: Bool {
        return !(self.isEmpty) && self.allSatisfy { $0.isNumber }
    }

    /// Checks if the string is a valid email address.
    /// - Returns: `true` if the string is a valid email, otherwise `false`.
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }

    /// Checks if the string is a valid phone number.
    /// - Returns: `true` if the string is a valid phone number, otherwise `false`.
    var isValidPhoneNumber: Bool {
        let phoneRegEx = "^\\+[1-9]\\d{1,14}$"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: self)
    }

    /// Checks if the string is empty.
    /// - Returns: `true` if the string is empty, otherwise `false`.
    var isEmpty: Bool {
        return self == ""
    }

    /// Checks if the string is a valid number (not starting with zero).
    /// - Returns: `true` if the string is a valid number, otherwise `false`.
    var isValidNumber: Bool {
        return self != "0" && self[self.startIndex] != "0"
    }

    /// Checks if the string is a valid Turkish citizen number (TCKN).
    /// - Returns: `true` if the string has exactly 11 characters, otherwise `false`.
    var isValidTCKN: Bool {
        return self.count == 11
    }
}



