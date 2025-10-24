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

    /// Returns the full name of the month formatted as "MMMM".
    var formatted_MMMM: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: self)
    }

    /// Returns the full name of the month and the year formatted as "MMMM yyyy".
    var formatted_MMMMyyy: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
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

    /// Returns the date formatted as "YYYY".
    var formatted_YYYY: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        return formatter.string(from: self)
    }

    /// Returns the time formatted as "HH:mm:ss.SSS".
    var formatted_HHmmssSSS: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        return formatter.string(from: self)
    }

    /// Returns the time formatted as "HH:mm:ss".
    var formatted_HHmmss: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: self)
    }

    /// Returns the date formatted as "dd.MM.yyyy, EEEE, HH:mm".
    var formatted_ddMMyyyyEEEEHHmm: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy',' EEEE',' HH:mm"
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

    /// Returns the year component of the date.
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }

    /// Returns the month component of the date.
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    /// Returns the day component of the date.
    var day: Int {
        return Calendar.current.component(.day, from: self)
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

    /// Returns an array of Dates representing the days shown in a calendar view for the month of the current date.
    var calendarDisplayDays: [Date] {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: self)!
        var dates: [Date] = []

        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
        let weekday = calendar.component(.weekday, from: firstOfMonth)
        let leadingEmptyDays = weekday - calendar.firstWeekday

        for i in stride(from: leadingEmptyDays, to: 0, by: -1) {
            if let date = calendar.date(byAdding: .day, value: -i, to: firstOfMonth) {
                dates.append(date)
            }
        }

        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth) {
                dates.append(date)
            }
        }

        let remaining = 42 - dates.count
        if remaining > 0 {
            if let last = dates.last {
                for i in 1...remaining {
                    if let date = calendar.date(byAdding: .day, value: i, to: last) {
                        dates.append(date)
                    }
                }
            }
        }

        return dates
    }

    /// Returns an array of short weekday names starting from Monday, with the first letter capitalized, localized to the given locale.
    /// - Parameter locale: The locale to use when generating weekday names. Defaults to `.current`.
    /// - Returns: An array of strings representing the capitalized short names of weekdays.
    static func shortCapitalizedFirstLettersOfWeekdays(locale: Locale = .current) -> [String] {
        let formatter = DateFormatter()
        formatter.locale = locale

        var calendar = Calendar.current
        calendar.locale = locale
        calendar.firstWeekday = 2

        let shortWeekdays = calendar.shortWeekdaySymbols
        let orderedWeekdays = Array(shortWeekdays[calendar.firstWeekday-1..<shortWeekdays.count] + shortWeekdays[0..<calendar.firstWeekday-1])
        let capitalizedShortWeekdays = orderedWeekdays.map { $0.capitalized }

        return capitalizedShortWeekdays
    }

    /// Returns a new Date by setting a calendar component to a specified value.
    /// - Parameters:
    ///   - component: The calendar component to modify.
    ///   - value: The new value to set.
    func setDate(_ component: Calendar.Component, value: Int) -> Date? {
        let calendar = Calendar.current
        var dateComp = calendar.dateComponents([.year, .month, .day], from: self)
        switch component {
        case .year:
            dateComp.year = value
        case .month:
            dateComp.month = value
        case .day:
            dateComp.day = value
        default:
            return nil
        }
        return calendar.date(from: dateComp)
    }


    /// Returns the name of the day if the date is in the future, or "Bugün" if it is today.
    var dayNameForFutureDate: String? {
        let calendar = Calendar.current
        let today = Date()

        guard self >= today else { return nil }

        if calendar.isDateInToday(self) {
            return  NSLocalizedString("Bugün", comment: "Bugün")
        }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "tr_TR")
        dateFormatter.dateFormat = "EEEE"

        return dateFormatter.string(from: self)
    }

    /// Returns true if the date is within the next six days (excluding today).
    var isInNextSixDays: Bool {
        let calendar = Calendar.current
        let today = Date()

        guard self >= today else { return true }

        if let sixDaysLater = calendar.date(byAdding: .day, value: 7, to: today), self <= sixDaysLater {

            return false
        }
        return true
    }

    var gmtOffsetString: String {
        let secondsFromGMT = TimeZone.current.secondsFromGMT()
        let hours = secondsFromGMT / 3600
        let minutes = abs(secondsFromGMT % 3600) / 60
        let sign = hours >= 0 ? "+" : "-"

        return String(format: "GMT%@%02d:%02d", sign, abs(hours), minutes)
    }

    var formatted_ddMMMyyPipeHHmm: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "dd MMM yy '|' HH:mm"

        return dateFormatter.string(from: self)
    }
}
