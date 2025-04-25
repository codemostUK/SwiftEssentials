//
//  NetworkMonitor.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 18.03.2023.
//

import Foundation
import Network

/// A network monitor class that tracks the device's connectivity and connection type using `NWPathMonitor`.
/// Compatible with Swift strict concurrency; all updates are executed on the main actor.
@MainActor
open class NetworkMonitor {

    /// Returns `true` if the device is currently connected to the internet.
    /// Uses the shared monitor instance with main-actor isolation for concurrency safety.
    public static var isConnected: Bool {
        return NetworkMonitor.shared.isConnected
    }

    /// Returns the current network connection type: Wi-Fi, Cellular, or None.
    /// Uses the shared monitor instance and is updated from the main actor.
    public static var connectionType: ConnectionType {
        return NetworkMonitor.shared.connectionType
    }

    /// Sets the current connection status with concurrency-safe update.
    /// - Parameter isConnected: A boolean indicating if the device is connected.
    public static func setIsConnected(_ isConnected: Bool) {
        NetworkMonitor.shared.isConnected = isConnected
    }

    /// Sets the current connection type with concurrency-safe update.
    /// - Parameter connectionType: The current connection type detected.
    public static func setConnectionType(_ connectionType: ConnectionType) {
        NetworkMonitor.shared.connectionType = connectionType
    }

    /// Singleton instance of `NetworkMonitor`.
    private static let shared = NetworkMonitor()

    /// A boolean that tracks the device's connection status.
    private var isConnected: Bool = false {
        willSet {
            switch newValue {
                case true:
                    guard isConnected == false else { return }
                    postNotification(.NetworkMonitorConnected)
                case false:
                    guard isConnected == true else { return }
                    postNotification(.NetworkMonitorDisconnected)
            }
        }
    }

    /// `NWPathMonitor` instance used to observe changes in the device's network path.
    private var monitor: NWPathMonitor = NWPathMonitor()

    /// Global queue on which the network path monitor runs; updates forwarded to the main actor.
    private let queue = DispatchQueue.global()

    /// Initializes the network monitor and sets up a path update handler that dispatches updates to the main actor.
    public init() {
        monitor.pathUpdateHandler = { path in
            Task { @MainActor in
                NetworkMonitor.setIsConnected(path.status == .satisfied)

                if path.usesInterfaceType(.wifi) {
                    NetworkMonitor.setConnectionType(.wifi)
                } else if path.usesInterfaceType(.cellular) {
                    NetworkMonitor.setConnectionType(.cellular)
                } else {
                    NetworkMonitor.setConnectionType(.none)
                }
            }
        }
    }

    /// Enum representing the types of network connections.
    public enum ConnectionType {
        case wifi
        case cellular
        case none
    }

    /// The last known network connection type, updated when a path change is observed.
    public private(set) var connectionType: ConnectionType = .none {
        didSet {
            postNotification(.NetworkMonitorConnectionTypeChanged)
        }
    }

    /// Starts monitoring the network path using the shared instance.
    public static func startMonitoring() {
        shared.startMonitoring()
    }

    /// Begins observing network path changes using the internal `NWPathMonitor`.
    private func startMonitoring() {
        monitor.start(queue: queue)
    }
}

// MARK: - Notification
public extension NSNotification.Name {
    static let NetworkMonitorConnected = Notification.Name("NetworkMonitorConnected")
    static let NetworkMonitorDisconnected = Notification.Name("NetworkMonitorDisconnected")
    static let NetworkMonitorConnectionTypeChanged = Notification.Name("NetworkMonitorConnectionTypeChanged")
}

// MARK: - Error
/// Error definitions related to `NetworkMonitor`, such as when no internet connection is available.
public enum NetworkMonitorError: Int, Error {
    case noInternetConnection = 999
}

extension NetworkMonitorError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .noInternetConnection:
                return NSLocalizedString("No internet connection.", comment: "Network connection error messages")
        }
    }
}
