//
//  EnumDefaultValueSelectable.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 12.09.2023.
//

/// A protocol that combines `Codable`, `CaseIterable`, and `RawRepresentable` for enumerations.
/// Types conforming to this protocol must be able to provide a default case from the available enum cases.
public protocol EnumDefaultValueSelectable: Codable & CaseIterable & RawRepresentable
    where RawValue: Decodable, AllCases: BidirectionalCollection { }

/// A type that provides the last case of an enum as the default value.
public struct LastCase<T>: DefaultCodableInterface where T: EnumDefaultValueSelectable {
    public static var defaultValue: T { T.allCases.last! }
}

/// A type that provides the first case of an enum as the default value.
public struct FirstCase<T>: DefaultCodableInterface where T: EnumDefaultValueSelectable {
    public static var defaultValue: T { T.allCases.first! }
}

/// A type that provides the default value `0.0` for `Double`.
public struct DoubleZero: DefaultCodableInterface {
    public static var defaultValue: Double { 0.0 }
}

/// A type that provides the default value `0` for `Int`.
public struct Zero: DefaultCodableInterface {
    public static var defaultValue: Int { 0 }
}

/// A type that provides the default value `0` for `Int64`.
public struct ZeroInt64: DefaultCodableInterface {
    public static var defaultValue: Int64 { 0 }
}

/// A type that provides the default value `false` for `Bool`.
public struct False: DefaultCodableInterface {
    public static var defaultValue: Bool { false }
}

/// A type that provides an empty array as the default value for any `Codable` type.
public struct EmptyArray<T>: DefaultCodableInterface where T: Codable {
    public static var defaultValue: [T] { [] }
}

/// A type that provides the default value `0.0` for `Float`.
public struct FloatZero: DefaultCodableInterface {
    public static var defaultValue: Float { 0.0 }
}

/// A type that provides the default value `true` for `Bool`.
public struct True: DefaultCodableInterface {
    public static var defaultValue: Bool { true }
}

/// A type that provides an empty string as the default value.
public struct EmptyString: DefaultCodableInterface {
    public static var defaultValue: String { "" }
}

/// A type that provides a random `Int64` value within the range 100_000_000_000_000_0000...Int64.max as the default value.
public struct RandInt64: DefaultCodableInterface {
    public static var defaultValue: Int64 { Int64.random(in: 100_000_000_000_000_0000...Int64.max) }
}
