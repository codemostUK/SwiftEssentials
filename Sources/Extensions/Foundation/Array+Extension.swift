//
//  Array+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import Foundation
import UIKit

// MARK: - Array Extensions

/// Extension for `Array` where the elements are `FloatingPoint` numbers.
/// Provides utility methods for calculating the sum and average of the array elements.
extension Array where Element: FloatingPoint {

    /// Computes the sum of all elements in the array.
    var sum: Element {
        return reduce(0, +)
    }

    /// Computes the average of all elements in the array.
    /// Returns `0` if the array is empty.
    var average: Element {
        guard !isEmpty else {
            return 0
        }
        return sum / Element(count)
    }
}

/// Extension for `Array` where the elements are `UILabel` objects.
/// Provides methods for managing text in the labels.
extension Array where Element: UILabel {

    /// Clears the text of all labels in the array.
    func clearText() {
        self.forEach { label in
            label.text = nil
        }
    }

    /// Sets the text of all labels in the array to the specified value.
    /// - Parameter newValue: The text to set for all labels.
    func setText(_ newValue: String?) {
        self.forEach { label in
            label.text = newValue
        }
    }
}

/// Extension for `Array` where the elements are `NSLayoutConstraint` objects.
/// Provides a method to update the constant value of each constraint.
extension Array where Element: NSLayoutConstraint {

    /// Updates the constant value of all constraints in the array.
    /// - Parameter constant: The new constant value to set.
    func updateConstant(constant: CGFloat) {
        self.forEach { constraint in
            constraint.constant = constant
        }
    }
}

/// Extension for `Array` where the elements are `UIView` objects.
/// Provides utility methods for managing the visibility, alpha, and hierarchy of views.
extension Array where Element: UIView {

    /// Sets the alpha value for all views in the array.
    /// - Parameter newValue: The new alpha value to set.
    func setAlpha(_ newValue: CGFloat) {
        self.forEach { view in
            view.alpha = newValue
        }
    }

    /// Removes all views in the array from their superview.
    func removeFromSuperView() {
        self.forEach { view in
            view.removeFromSuperview()
        }
    }
}

/// Extension for `Array` where the elements are `Equatable`.
/// Provides a method to remove a specific element from the array.
extension Array where Element: Equatable {

    /// Removes the first occurrence of the specified element from the array.
    /// - Parameter element: The element to remove.
    mutating func remove(_ element: Element) {
        if let index = firstIndex(of: element) {
            remove(at: index)
        }
    }
}

/// Extension for `Array` where the elements are `NSObjectProtocol`.
/// Provides a method to unsubscribe and remove all elements.
extension Array where Element == NSObjectProtocol {

    /// Unsubscribes all elements from notifications and removes them from the array.
    mutating func unsubscribeAndRemoveAll() {
        for subscriber: NSObjectProtocol in self {
            NotificationCenter.default.removeObserver(subscriber)
        }
        self.removeAll()
    }
}

/// General extension for `Array`.
/// Provides a method to safely access elements by index.
extension Array {

    /// Safely retrieves the element at the specified index, if it exists.
    /// - Parameter index: The index of the element to retrieve.
    /// - Returns: The element at the specified index, or `nil` if the index is out of bounds.
    func safe(at index: Int) -> Element? {
        guard index >= 0 && index < count else {
            return nil
        }
        return self[index]
    }
}
