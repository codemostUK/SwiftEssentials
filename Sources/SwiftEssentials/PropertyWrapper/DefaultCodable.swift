//
//  DefaultCodable.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 12.09.2023.
//

/// A protocol that defines a default value for a type conforming to `Codable`.
/// Types conforming to this protocol must define a `RawValue` type that is `Codable`,
/// and provide a default value for instances of that type.
public protocol DefaultCodableInterface {
    associatedtype RawValue: Codable

    /// The default value for the conforming type.
    static var defaultValue: RawValue { get }
}

@propertyWrapper
/// A property wrapper that provides a default value for a type conforming to `Codable`.
/// It uses the default value when decoding fails or when no value is provided.
public struct DefaultCodable<T: DefaultCodableInterface>: Codable {
    public var wrappedValue: T.RawValue

    /// Initializes the property wrapper with the provided value.
    /// - Parameter wrappedValue: The value to wrap, or the default value if not provided.
    public init(wrappedValue: T.RawValue) {
        self.wrappedValue = wrappedValue
    }

    /// Initializes the property wrapper from a decoder.
    /// If decoding fails, the default value defined in the `DefaultCodableInterface` will be used.
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: An error if the decoding process fails unexpectedly.
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = (try? container.decode(T.RawValue.self)) ?? T.defaultValue
    }

    /// Encodes the wrapped value to an encoder.
    /// - Parameter encoder: The encoder to write data to.
    /// - Throws: An error if encoding fails.
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

extension DefaultCodable: Equatable where T.RawValue: Equatable { }
extension DefaultCodable: Hashable where T.RawValue: Hashable { }
