//
//  ExpressibleByBool.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 22.02.2024.
//

import Foundation

/// A protocol for types that can be initialized with a `Bool`.
public protocol ExpressibleByBool {
    init(_ bool: Bool)
}

extension Bool: ExpressibleByBool {
    public init(_ bool: Bool) { self = bool }
}

extension Optional: ExpressibleByBool where Wrapped == Bool {
    public init(_ bool: Bool) { self = bool }
}

/// A protocol for types that can be initialized with a `Date`.
public protocol ExpressibleByDate {
    init(_ dateValue: Date)
}

extension Date: ExpressibleByDate {
    public init(_ dateValue: Date) { self = dateValue }
}

extension Optional: ExpressibleByDate where Wrapped == Date {
    public init(_ dateValue: Date) { self = dateValue }
}

/// A protocol for types that can be initialized with a `String`.
public protocol ExpressibleByString {
    init(_ stringValue: String)
}

extension String: ExpressibleByString {
    public init(_ stringValue: String) { self = stringValue }
}

extension Optional: ExpressibleByString where Wrapped == String {
    public init(_ stringValue: String) { self = stringValue }
}

/// A protocol for types that can be initialized with an `Int`.
public protocol ExpressibleByInt {
    init(_ intValue: Int)
}

extension Int: ExpressibleByInt {
    public init(_ intValue: Int) { self = intValue }
}

extension Optional: ExpressibleByInt where Wrapped == Int {
    public init(_ intValue: Int) { self = intValue }
}

/// A property wrapper that decodes a `Bool` from numbers or strings.
/// It attempts to decode the value from an `Int`, `String`, or `Bool`, defaulting to false if no value is provided.
@propertyWrapper
public struct NumberOrStringBool<BoolValue: ExpressibleByBool & Codable>: Codable {
    public var wrappedValue: BoolValue

    public init(wrappedValue: BoolValue) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self.wrappedValue = BoolValue(intValue != 0)
        } else if let stringValue = try? container.decode(String.self) {
            let lowerCased = stringValue.lowercased()
            self.wrappedValue = BoolValue( lowerCased == "true" || lowerCased == "yes" || lowerCased == "1")
        } else {
            self.wrappedValue = BoolValue(try container.decode(Bool.self))
        }
    }

    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }

    enum CodingKeys: CodingKey {
        case wrappedValue
    }
}

/// A property wrapper that decodes a `Date` from a timestamp representing seconds since 1970.
/// It attempts to handle different timestamp formats and adjusts precision accordingly.
@propertyWrapper
public struct SecondsSince1970Date<DateValue: ExpressibleByDate & Codable>: Codable {
    public var wrappedValue: DateValue

    public init(wrappedValue: DateValue) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let dictionary = try? container.decode(Dictionary<String, Int>.self),
           var wrappedIntValue = dictionary[CodingKeys.wrappedValue.rawValue] {

            let intString = String(wrappedIntValue)

            switch intString.count {
                case 16:
                    wrappedIntValue = wrappedIntValue / 1_000_000
                case 13:
                    wrappedIntValue = wrappedIntValue / 1_000
                default:
                    break
            }
            wrappedValue = Date(timeIntervalSince1970: TimeInterval(wrappedIntValue)) as! DateValue
        } else if var wrappedIntValue = try? container.decode(Int.self) {
            let intString = String(wrappedIntValue)

            switch intString.count {
                case 16:
                    wrappedIntValue = wrappedIntValue / 1_000_000
                case 13:
                    wrappedIntValue = wrappedIntValue / 1_000
                default:
                    break
            }
            wrappedValue = Date(timeIntervalSince1970: TimeInterval(wrappedIntValue)) as! DateValue
        } else {
            wrappedValue = Date() as! DateValue
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let dateValue = self.wrappedValue as! Date
        try container.encode(dateValue.timeIntervalSince1970.toInt, forKey: .wrappedValue)
    }

    enum CodingKeys: String, CodingKey {
        case wrappedValue
    }
}

/// A property wrapper that decodes and encodes a `Date` formatted as `yyyy-MM-dd`.
@propertyWrapper
public struct FormattedDate_yyyy_MM_dd<DateValue: ExpressibleByDate & Codable>: Codable {
    public var wrappedValue: DateValue

    public init(wrappedValue: DateValue) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        wrappedValue = try formatter.date(from: container.decode(String.self)) as! DateValue
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let dateValue = self.wrappedValue as! Date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        try container.encode(formatter.string(from: dateValue))
    }

    enum CodingKeys: CodingKey {
        case wrappedValue
    }
}

/// A property wrapper that decodes and encodes a `Date` formatted in ISO 8601 with full date and time.
@propertyWrapper
public struct FormattedDate_ISO8601<DateValue: ExpressibleByDate & Codable>: Codable {
    public var wrappedValue: DateValue

    public init(wrappedValue: DateValue) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let date = formatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format.")
        }

        wrappedValue = DateValue(date)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let dateValue = self.wrappedValue as! Date
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        try container.encode(formatter.string(from: dateValue))
    }
}
