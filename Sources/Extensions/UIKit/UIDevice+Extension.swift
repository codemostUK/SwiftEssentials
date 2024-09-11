//
//  UIDevice+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.06.2024.
//

import UIKit

public extension UIDevice {

    /// Retrieves the current app version from the bundle.
    /// - Returns: A string representing the app version (e.g., "1.0.0"). Returns "0.0.0" if the version is not found.
    static var appVersion: String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "0.0.0"
    }

    /// Retrieves the current operating system version.
    /// - Returns: A string representing the iOS version (e.g., "16.2").
    static var osVersion: String {
        return UIDevice.current.systemVersion
    }

    /// Retrieves the Identifier for Vendor (IDFV), a unique identifier for the app across devices.
    /// - Returns: A string representing the IDFV or `nil` if it cannot be retrieved.
    static var idfv: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }

    /// Determines if the device has a notch by checking the top safe area inset.
    /// - Returns: `true` if the device has a notch, `false` otherwise.
    static var hasNotch: Bool {
        return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0 > 20
    }
}
