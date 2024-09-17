//
//  ExpandableByKeyboardController.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import UIKit

/// An open controller that manages a view's layout, expanding it when the keyboard appears and shrinking it when the keyboard hides.
open class ExpandableByKeyboardController: NSObject, NotificationSubscriber {

    @IBOutlet public weak var scrollView: UIScrollView! {
        didSet {
            addSubscribers() // Add keyboard notification subscribers when the scrollView is set.
        }
    }

    @IBOutlet public weak var constraint: NSLayoutConstraint! {
        didSet {
            addSubscribers() // Add keyboard notification subscribers when the constraint is set.
        }
    }

    @IBOutlet public weak var parentView: UIView! {
        didSet {
            addSubscribers() // Add keyboard notification subscribers when the parentView is set.
        }
    }

    /// Additional padding for the scroll view when the keyboard is shown.
    @IBInspectable public var extraPaddingForScrollView: CGFloat = 0

    public var subscribers: [NSObjectProtocol]?

    public override init() {
        super.init()
    }

    deinit {
        cleanSubscribers() // Clean up subscribers when the object is deallocated.
    }
}

// MARK: - Notifications
public extension ExpandableByKeyboardController {

    /// Adds subscribers for keyboard show and hide notifications.
    private func addSubscribers() {
        // Avoid adding multiple subscribers if they already exist.
        guard subscribers == nil else { return }

        // Subscribe to keyboard show and hide notifications.
        addSubscribers(forNames: [UIResponder.keyboardWillShowNotification, UIResponder.keyboardWillHideNotification]) { [weak self] notification in
            guard let self = self else { return }

            // Handle keyboard appearance or disappearance based on the notification name.
            switch notification.name {
            case UIResponder.keyboardWillShowNotification:
                self.keyboardWillShow(notification) // Call the handler for when the keyboard shows.
            case UIResponder.keyboardWillHideNotification:
                self.keyboardWillHide(notification) // Call the handler for when the keyboard hides.
            default:
                break
            }
        }
    }

    /// Adjusts the scroll view and view constraints when the keyboard appears.
    /// - Parameter notification: The keyboard notification containing the keyboard's size and animation duration.
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            // Calculate the height of the keyboard, accounting for safe area insets.
            let keyboardHeight = keyboardFrame.size.height - (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0)

            // Adjust the scroll view content inset to make room for the keyboard.
            if scrollView != nil {
                let keyboardHeightForScrollView = extraPaddingForScrollView + keyboardHeight
                let insets = UIEdgeInsets(top: scrollView.contentInset.top,
                                          left: scrollView.contentInset.left,
                                          bottom: keyboardHeightForScrollView,
                                          right: scrollView.contentInset.right)
                scrollView.contentInset = insets
                scrollView.scrollIndicatorInsets = insets
            }

            // Adjust the view's bottom constraint to accommodate the keyboard's height.
            if constraint != nil && parentView != nil {
                constraint.constant = keyboardHeight

                // Animate the layout change with the same duration as the keyboard's appearance.
                if let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                    UIView.animate(withDuration: animationDuration) {
                        self.parentView.layoutIfNeeded()
                    }
                }
            }
        }
    }

    /// Resets the scroll view and view constraints when the keyboard hides.
    /// - Parameter notification: The keyboard notification containing the animation duration.
    @objc func keyboardWillHide(_ notification: Notification) {
        // Reset the scroll view content inset back to its original state.
        if scrollView != nil {
            let insets = UIEdgeInsets(top: scrollView.contentInset.top,
                                      left: scrollView.contentInset.left,
                                      bottom: 0,
                                      right: scrollView.contentInset.right)
            scrollView.contentInset = insets
            scrollView.scrollIndicatorInsets = insets
        }

        // Reset the view's bottom constraint to the original padding.
        if constraint != nil && parentView != nil {
            constraint.constant = extraPaddingForScrollView

            // Animate the layout change to match the keyboard's hide animation duration.
            if let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                UIView.animate(withDuration: animationDuration) {
                    self.parentView.layoutIfNeeded()
                }
            }
        }
    }
}
