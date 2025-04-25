//
//  UserDefaults+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import Foundation

public extension UserDefaults {

    /// Encodes a `Codable` object and stores it in `UserDefaults` under the specified key.
    /// - Parameters:
    ///   - codable: The `Codable` object to encode and store.
    ///   - key: The key under which to store the encoded object.
    /// - Returns: `true` if encoding and storing were successful, `false` otherwise.
    func encode<T: Codable>(codable: T, key: String) -> Bool {
        let encoder = JSONEncoder()
        if let encodedStruct = try? encoder.encode(codable) {
            self.set(encodedStruct, forKey: key)
            return true
        }
        return false
    }

    /// Decodes a `Codable` object from `UserDefaults` for the specified key.
    /// - Parameters:
    ///   - codableType: The type of the `Codable` object to decode.
    ///   - key: The key for the stored encoded object.
    /// - Returns: The decoded object if successful, or `nil` if decoding fails.
    func decode<T: Codable>(codableType: T.Type, key: String) -> T? {
        if let encodedData = self.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let decodedStruct = try? decoder.decode(codableType, from: encodedData) {
                return decodedStruct
            }
        }
        return nil
    }

    /// Checks if a key exists in `UserDefaults`.
    /// - Parameter key: The key to check for existence.
    /// - Returns: `true` if the key exists, `false` otherwise.
    func isKeyExists(key: String) -> Bool {
        return self.object(forKey: key) != nil
    }

    /// Decodes a `Codable` object from `UserDefaults` for the specified key and throws an error if decoding fails.
    /// - Parameters:
    ///   - codableType: The type of the `Codable` object to decode.
    ///   - key: The key for the stored encoded object.
    /// - Throws: An error if decoding fails.
    /// - Returns: The decoded object if successful, or `nil` if no object exists for the key.
    func decode2<T: Codable>(codableType: T.Type, key: String) throws -> T? {
        if let encodedData = self.object(forKey: key) as? Data {
            return try JSONDecoder().decode(codableType, from: encodedData)
        }
        return nil
    }
}
