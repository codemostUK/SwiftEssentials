//
//  KeyedDecodingContainer.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.05.2023.
//

public extension KeyedDecodingContainer {

    /// Decodes a `DefaultCodable` value for the given key.
    /// If the decoding process fails or the key is not present, the default value from the `DefaultCodableInterface` is used.
    /// - Parameters:
    ///   - type: The type to decode, which conforms to `DefaultCodableInterface`.
    ///   - key: The key identifying the value to decode.
    /// - Returns: A `DefaultCodable` value, using the default value if decoding fails.
    /// - Throws: An error if the decoding process fails unexpectedly.
    func decode<T>(_: DefaultCodable<T>.Type, forKey key: Key) throws -> DefaultCodable<T> {
        // Attempt to decode the value
        if let value = try decodeIfPresent(DefaultCodable<T>.self, forKey: key) {
            return value
        }
        // If decoding fails, return the default value from the struct
        return DefaultCodable(wrappedValue: T.defaultValue)
    }

    /// Decodes a `NumberOrStringBool` value for the given key.
    /// If the decoding process fails or the key is not present, the default value `nil` is used.
    /// - Parameters:
    ///   - type: The type to decode, which conforms to `ExpressibleByNilLiteral`.
    ///   - key: The key identifying the value to decode.
    /// - Returns: A `NumberOrStringBool` value, using `nil` if decoding fails.
    /// - Throws: An error if the decoding process fails unexpectedly.
    func decode<T: ExpressibleByNilLiteral>(_ type: NumberOrStringBool<T>.Type, forKey key: Key) throws -> NumberOrStringBool<T> {
        if let value = try decodeIfPresent(type, forKey: key) {
            return value
        }
        return NumberOrStringBool(wrappedValue: nil)
    }

    /// Decodes a `SecondsSince1970Date` value for the given key.
    /// If the decoding process fails or the key is not present, the default value `nil` is used.
    /// - Parameters:
    ///   - type: The type to decode, which conforms to `ExpressibleByNilLiteral`.
    ///   - key: The key identifying the value to decode.
    /// - Returns: A `SecondsSince1970Date` value, using `nil` if decoding fails.
    /// - Throws: An error if the decoding process fails unexpectedly.
    func decode<T: ExpressibleByNilLiteral>(_ type: SecondsSince1970Date<T>.Type, forKey key: Key) throws -> SecondsSince1970Date<T> {
        if let value = try decodeIfPresent(type, forKey: key) {
            return value
        }
        return SecondsSince1970Date(wrappedValue: nil)
    }
}
