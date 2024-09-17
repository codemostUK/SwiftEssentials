//
//  UIScrollView+Extensions.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 21.08.2024.
//

import UIKit
import Foundation

public extension UIScrollView {

    /// Scrolls the scroll view to the top.
    ///
    /// This method adjusts the scroll view's content offset to make the top of the content visible.
    /// The scrolling is done without animation.
    func scrollToTop() {
        // Scrolls to the top of the scroll view
        scrollRectToVisible(CGRect.zero, animated: false)
    }

    /// Scrolls the scroll view to a specific view's position.
    ///
    /// This method adjusts the scroll view's content offset to make the specified view visible at the desired position.
    /// - Parameters:
    ///   - view: The view to scroll to.
    ///   - position: The position of the view in the scroll view (top, middle, or bottom). Default is `.middle`.
    ///   - animated: A boolean indicating whether the scrolling should be animated.
    func scrollToView(view: UIView, position: ScrollPosition = .middle, animated: Bool) {
        if let origin = view.superview {
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            var height: CGFloat = 0

            switch position {
                case .top:
                    height = 0
                case .middle:
                    height = UIScreen.main.bounds.height / 2.0
                case .bottom:
                    height = UIScreen.main.bounds.height
            }
            self.scrollRectToVisible(CGRect(x: 0, y: childStartPoint.y - height, width: 1, height: self.frame.height), animated: animated)
        }
    }

    enum ScrollPosition {
        case top
        case middle
        case bottom
    }
}
