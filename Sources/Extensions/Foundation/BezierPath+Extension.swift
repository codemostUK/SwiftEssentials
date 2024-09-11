//
//  BezierPath+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import Foundation
import UIKit

public extension UIBezierPath {

    /// Creates and returns a circular `UIBezierPath` with the given radius.
    /// - Parameter radius: The radius of the circle.
    /// - Returns: A `UIBezierPath` representing a circle.
    static func circlePathFor(radius: CGFloat) -> UIBezierPath {
        let center = CGPoint(x: radius, y: radius)
        let bezierPath = UIBezierPath()
        bezierPath.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: Double.pi * 2, clockwise: true)
        return bezierPath
    }

    /// Creates and returns a rectangular `UIBezierPath` with the given size.
    /// - Parameter size: The size of the rectangle.
    /// - Returns: A `UIBezierPath` representing a rectangle.
    static func rectanglePathFor(size: CGSize) -> UIBezierPath {
        return UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: size))
    }

    /// Creates and returns a rounded rectangular `UIBezierPath` with the given size and corner radius.
    /// - Parameters:
    ///   - size: The size of the rectangle.
    ///   - cornerRadius: The corner radius of the rectangle. If set to `0`, a standard rectangle is returned.
    /// - Returns: A `UIBezierPath` representing a rounded rectangle or standard rectangle.
    static func roundedRectanglePathFor(size: CGSize, cornerRadius: CGFloat) -> UIBezierPath {
        if cornerRadius == 0 {
            return rectanglePathFor(size: size)
        } else {
            return UIBezierPath(roundedRect: CGRect(origin: CGPoint.zero, size: size), cornerRadius: cornerRadius)
        }
    }
}
