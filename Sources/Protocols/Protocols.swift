//
//  Protocols.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import Foundation
import UIKit

// MARK: - Protocols

/// Represents an element that can be marked as alternate, typically for UI purposes.
protocol Alternateable where Self: UIView {
    var isAlternate: Bool? { get set }
}

/// Represents an entity that can encode in a parent container.
protocol CodingKeysMappable {
    func valuefor(_ codingKey: CodingKey) -> Encodable?
}

/// Represents an element that can hold generic data.
protocol DataSettable where Self: AnyObject {
    var data: AnyObject? { get set }
}

/// Represents an element that can have a delegate assigned.
protocol DelegateSettable where Self: UIResponder {
    var delegate: NSObjectProtocol? { get set }
}

/// Represents an element that can be edited.
protocol Editable where Self: AnyObject {
    var isEditable: Bool { get set }
}

/// Represents an entity that can be expanded or collapsed.
protocol Expandable {
    var isExpanded: Bool { get set }
}

/// Represents an element with a fixed height.
protocol FixedHeight where Self: UIResponder {
    static var height: CGFloat { get }
}

/// Represents an element with a fixed size.
protocol FixedSize where Self: UIResponder {
    static var size: CGSize { get }
}

/// Represents an element that can be flagged, typically for UI or data tracking purposes.
protocol Flaggable where Self: AnyObject {
    var flag: Bool { get set }
}

/// Represents an element that can be marked as the first item.
protocol FirstMarkable where Self: AnyObject {
    var isFirstItem: Bool { get set }
}

/// Represents an element that can have an initial state.
protocol InitialStateSettable where Self: UIResponder {
    var initialState: AnyObject? { get set }
}

/// Represents a label that can have insets applied to its drawing.
protocol InsettableLabel: UILabel {
    func draw(_ rect: CGRect)
}

/// Represents an element that is marked as the last item.
protocol LastMarkable where Self: AnyObject {
    var isLastItem: Bool { get set }
}

/// Represents an entity that can play and pause media content.
protocol MediaPlayable {
    func playMedia()
    func pauseMedia()
}

/// Represents an entity that subscribes to notifications.
protocol NotificationSubscriber: AnyObject {
    var subscribers: [NSObjectProtocol]? { get set }
    func addSubscribers(forNames names: [NSNotification.Name]?, using block: @escaping (Notification) -> Void)
    func cleanSubscribers()
}

/// Represents an entity that can encode in a parent container.
protocol ParentContainerEncodable {
    func encodeIn<T>(_ container: KeyedEncodingContainer<T>) -> KeyedEncodingContainer<T> where T: CodingKey
}

/// Represents an element that can be shared.
protocol ShareableContent {
    var shareContent: Any? { get }
}

/// Represents an element that can have a side (e.g., home or away).
protocol Sideable where Self: UIView {
    var isHome: Bool? { get set }
}

/// Represents an element that can be identified by a segue.
protocol SegueIdentifiable where Self: UIResponder {
    var segueIdentifier: String { get }
}

/// Represents an element that responds to tap gestures.
protocol TapDelegate: NSObjectProtocol {
    func didTap(_ ofType: Any.Type)
}

/// Represents an element that can update its user interface.
protocol UIUpdateable {
    func updateUI()
}

/// Represents an element with variable height, depending on data.
protocol VariableHeight where Self: Any {
    static func heightForData(_ data: AnyObject?, isLastItem: Bool) -> CGFloat
}

/// Represents an element with variable size, depending on data.
protocol VariableSize where Self: UIResponder {
    static func sizeForData(_ data: AnyObject?) -> CGSize
}

// MARK: - Protocol Extensions

extension NotificationSubscriber {
    func addSubscribers(forNames names: [NSNotification.Name]?, using block: @escaping (Notification) -> Void) {
        if (subscribers == nil) { subscribers = [] }
        names?.forEach {
            subscribers?.append(NotificationCenter.default.addObserver(forName: $0, object: nil, queue: nil, using: block))
        }
    }

    func cleanSubscribers() {
        subscribers?.unsubscribeAndRemoveAll()
    }
}

extension SegueIdentifiable {
    static var segueIdentifier: String {
        get {
            String("segueTo\(Self.identifier)")
        }
    }
}
