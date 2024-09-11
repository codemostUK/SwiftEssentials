//
//  Global+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import Foundation
import UIKit

/// Opens the specified URL link in the browser.
/// - Parameter link: The string representing the URL to open.
func goto(_ link: String?) {
    if let link = link, let linkTogo = URL(string: link) {
        UIApplication.shared.open(linkTogo.sanitise)
    }
}

/// Opens the specified URL in the browser.
/// - Parameter url: The `URL` to open.
func goto(_ url: URL) {
    UIApplication.shared.open(url.sanitise)
}

/// Opens the specified URL link in the browser after a delay.
/// - Parameters:
///   - link: The string representing the URL to open.
///   - afterSeconds: The delay (in seconds) before opening the URL.
func goto(_ link: String?, _ afterSeconds: Double) {
    DispatchQueue.main.asyncAfter(deadline: .now() + afterSeconds, execute: {
        goto(link)
    })
}

/// Opens the app's settings in the system preferences.
func gotoSettings() {
    if let url = URL(string: UIApplication.openSettingsURLString) {
        UIApplication.shared.open(url)
    }
}

/// Posts a notification with the specified name.
/// - Parameter name: The name of the notification to post.
func postNotification(_ name: Notification.Name) {
    NotificationCenter.default.post(name: name, object: nil)
}

/// Posts a notification with the specified name and user information.
/// - Parameters:
///   - name: The name of the notification to post.
///   - userInfo: A dictionary of user information to include with the notification.
func postNotification(_ name: Notification.Name, userInfo: [String: Any]?) {
    if let userInfo = userInfo {
        NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo)
    } else {
        postNotification(name)
    }
}
