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
