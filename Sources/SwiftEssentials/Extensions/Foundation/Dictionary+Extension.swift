//
//  Dictionary+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 08.03.2024.
//

import Foundation

public extension Dictionary {

    /// Decodes the dictionary into a specified `Codable` type.
    /// - Returns: The decoded object of type `T` if successful, or `nil` if the decoding fails.
    func decode<T: Codable>() -> T? {
        // Convert the dictionary to JSON data.
        if let data = try? JSONSerialization.data(withJSONObject: self) {
            // Decode the JSON data into the specified `Codable` type.
            return try? JSONDecoder().decode(T.self, from: data)
        }
        // Return nil if decoding fails.
        return nil
    }

    /// Converts the dictionary into a query string format.
    /// - Returns: The query string representation of the dictionary, or `nil` if the conversion fails.
    var queryString: String? {
        // Reduce the dictionary into a query string format.
        return self.reduce("") { "\($0!)\($1.0)=\($1.1)&" }
    }
}
