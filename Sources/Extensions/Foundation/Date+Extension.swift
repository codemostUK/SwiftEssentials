//
//  Date+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import Foundation

public extension Date {

    /// Returns the date formatted as "dd.MM.yyyy".
    var formatted_ddMMyyyy: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }

    /// Returns the date formatted as "dd.MM".
    var formatted_ddMM: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        return formatter.string(from: self)
    }

    /// Returns the date formatted as "dd/MM/yyyy".
    var formatted_ddSlashMMSlashyyyy: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }

    /// Returns the date formatted as "dd/MM/yy".
    var formatted_ddSlashMMSlashyy: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: self)
    }

    /// Returns the date formatted as "dd/MM".
    var formatted_ddSlashMM: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: self)
    }

    /// Returns the time formatted as "HH:mm".
    var formatted_HHmm: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }

    /// Returns the date and time formatted as "dd.MM.yyyy HH:mm".
    var formatted_ddMMyyyyHHmm: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: self)
    }

    /// Returns the date formatted as "yy.MM".
    var formatted_yyMM: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM"
        return formatter.string(from: self)
    }

    /// Returns the day formatted as "dd".
    var formatted_dd: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }

    /// Returns the abbreviated month formatted as "LLL".
    var formatted_MMM: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL"
        return formatter.string(from: self)
    }

    /// Returns the date formatted as "dd MMM yyyy EEEE".
    var formatted_ddMMyyyyEEEE: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy EEEE"
        return formatter.string(from: self)
    }

    /// Returns the date formatted as "MM/yyyy".
    var formatted_MMSlashyyyy: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yyyy"
        return formatter.string(from: self)
    }

    /// Returns the date formatted as "MM/yy".
    var formatted_MMSlashyy: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yy"
        return formatter.string(from: self)
    }

    /// Returns the date formatted as "dd MMMM yyyy | HH:mm".
    var formatted_ddMMMyyyyPipeHHmm: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "dd MMMM yyyy '|' HH:mm"

        return dateFormatter.string(from: self)
    }

    /// Returns the date formatted as "d MMMM".
    var formatted_dMMM: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "d MMMM"

        return dateFormatter.string(from: self)
    }

    /// Returns the date and time formatted as "dd.MM.yyyy HH:mm:ss".
    var formatted_ddMMyyyyHHmmss: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return formatter.string(from: self)
    }

    /// Returns the date and time formatted as "dd.MM.yyyy HH:mm:ss.SSS".
    var formatted_ddMMyyyyHHmmssSSS: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss.SSS"
        return formatter.string(from: self)
    }

    /// Returns a `Date` instance representing only the year, month, and day of the current date.
    var onlyDate: Date? {
        get {
            let calender = Calendar.current
            var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            dateComponents.timeZone = NSTimeZone.system
            return calender.date(from: dateComponents)
        }
    }

    /// Returns the date converted for live matches, subtracting a day if the current hour is before 6.
    var liveMatchesConverted: Date {
        let hour = Calendar.current.component(.hour, from: self)

        if hour < 6 {
            var dayComponent = DateComponents()
            dayComponent.day = -1 // For removing one day (yesterday): -1
            let theCalendar = Calendar.current
            if let yesterday = theCalendar.date(byAdding: dayComponent, to: self) {
                return yesterday
            } else {
                return  self
            }
        } else {
            return  self
        }
    }

    /// Returns the number of minutes since the specified date.
    /// - Parameter date: The reference date.
    func minutesSince(date: Date) -> Int {
        let interval = self.timeIntervalSince(date)
        return Int(interval / 60)
    }

    /// Returns a string representing the time passed since the date (e.g., "5m ago").
    func timeAgo() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .numeric
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }

    /// Returns a string representing the time passed since the date in abbreviated form (e.g., "5m").
    func timeAgoAbbreviated() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

public extension Date {
    /// Returns a new date with the specified number of seconds subtracted.
    /// - Parameter seconds: The number of seconds to subtract.
    func subtract(seconds: Int) -> Date? {
        Calendar.current.date(byAdding: .second, value: -seconds, to: self)
    }

    /// Returns a new date with the specified number of seconds added.
    /// - Parameter seconds: The number of seconds to add.
    func adding(seconds: Int) -> Date? {
        Calendar.current.date(byAdding: .second, value: seconds, to: self)
    }

    /// Returns a new date with the specified number of minutes added.
    /// - Parameter minutes: The number of minutes to add.
    func adding(minutes: Int) -> Date? {
        Calendar.current.date(byAdding: .minute, value: minutes, to: self)
    }

    /// Returns a new date with the specified number of hours added.
    /// - Parameter hours: The number of hours to add.
    func adding(hours: Int) -> Date? {
        Calendar.current.date(byAdding: .hour, value: hours, to: self)
    }
}
