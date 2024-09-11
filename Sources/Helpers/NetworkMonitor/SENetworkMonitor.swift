//
//  SENetworkMonitor.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 18.03.2023.
//

import Foundation
import Network

/// A network monitor class that tracks the device's connectivity and connection type.
/// It uses `NWPathMonitor` to observe changes in network status and posts notifications when the connection state changes.
final class SENetworkMonitor {

    /// Returns `true` if the device is connected to the internet.
    static var isConnected: Bool {
        return SENetworkMonitor.shared.isConnected
    }

    /// Returns the current connection type (Wi-Fi, Cellular, or None).
    static var connectionType: ConnectionType {
        return SENetworkMonitor.shared.connectionType
    }

    /// Singleton instance of `SENetworkMonitor`.
    private static let shared = SENetworkMonitor()

    /// A boolean that tracks the device's connection status.
    private var isConnected: Bool = false {
        didSet {
            switch isConnected {
            case true:
                postNotification(.SENetworkMonitorConnected)
            case false:
                postNotification(.SENetworkMonitorDisconnected)
            }
        }
    }

    /// The monitor used to track network path changes.
    private var monitor: NWPathMonitor = NWPathMonitor()

    /// A global dispatch queue for monitoring network changes.
    private let queue = DispatchQueue.global()

    /// Initializes the network monitor and starts observing network changes.
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            self.isConnected = path.status == .satisfied

            if path.usesInterfaceType(.wifi) {
                self.connectionType = .wifi
            } else if path.usesInterfaceType(.cellular) {
                self.connectionType = .cellular
            } else {
                self.connectionType = .none
            }
        }
    }

    /// Enum representing the types of network connections.
    enum ConnectionType {
        case wifi
        case cellular
        case none
    }

    /// The current connection type, set when a network change is detected.
    private(set) var connectionType: ConnectionType = .none {
        didSet {
            postNotification(.SENetworkMonitorConnectionTypeChanged)
        }
    }

    /// Starts monitoring the network status.
    static func startMonitoring() {
        shared.startMonitoring()
    }

    /// Private method to start monitoring network path changes.
    private func startMonitoring() {
        monitor.start(queue: queue)
    }
}

// MARK: - Notification
extension NSNotification.Name {
    static let SENetworkMonitorConnected = Notification.Name("SENetworkMonitorConnected")
    static let SENetworkMonitorDisconnected = Notification.Name("SENetworkMonitorDisconnected")
    static let SENetworkMonitorConnectionTypeChanged = Notification.Name("SENetworkMonitorConnectionTypeChanged")
}

// MARK: - Error
/// Custom errors for `SENetworkMonitor`, such as no internet connection.
enum SENetworkMonitorError: Int, Error {
    case noInternetConnection = 999
}

extension SENetworkMonitorError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return NSLocalizedString("No internet connection.", comment: "Network connection error messages")
        }
    }
}
