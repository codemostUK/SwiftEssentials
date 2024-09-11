//
//  Data+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import Foundation

public extension Data {

    /// Converts the `Data` object into a string representation of the device token.
    /// - Returns: A string representing the device token, formatted as hexadecimal.
    var deviceTokenString: String? {
        return self.map { String(format: "%02.2hhx", $0) }.joined()
    }

    /// Converts the `Data` object into a pretty-printed JSON string, if possible.
    /// - Returns: A formatted JSON string, or `nil` if the conversion fails.
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
