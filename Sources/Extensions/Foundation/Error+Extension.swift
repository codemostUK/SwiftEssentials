//
//  Error+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 29.04.2024.
//

import Foundation

public extension Error {
    
    /// Creates a custom error with the specified domain, message, and code.
    /// - Parameters:
    ///   - domain: The domain of the error.
    ///   - message: An optional message describing the error.
    ///   - code: The error code.
    /// - Returns: An `NSError` instance with the specified parameters.
    static func error(_ domain: String, message: String?, code: Int) -> Error {
        // Create and return an NSError with the given domain, message, and code.
        return NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey : message ?? "error_unknown".localized])
    }
}
