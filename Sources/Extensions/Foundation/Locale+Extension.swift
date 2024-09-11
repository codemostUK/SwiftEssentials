//
//  Locale+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 15.11.2023.
//

import Foundation

public extension Locale {
    
    /// Returns a `Locale` object that matches the specified currency code.
    /// - Parameter currencyCode: The currency code for which to find the corresponding locale.
    /// - Returns: A `Locale` object matching the currency code, or the current locale if no match is found.
    static func locale(from currencyCode: String?) -> Locale {
        guard let currencyCode = currencyCode else {
            return Locale.current
        }
        
        for localId in Locale.availableIdentifiers {
            let locale = Locale(identifier: localId)
            
            if locale.currencyCode == currencyCode {
                return locale
            }
        }
        
        return Locale.current
    }
}
