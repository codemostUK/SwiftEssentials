//
//  ShapeLayer+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import Foundation
import UIKit

public extension CAShapeLayer {

    /// Creates and returns a `CAShapeLayer` with a shadow based on the specified `UIBezierPath`.
    /// - Parameter path: The `UIBezierPath` used to define the layer's shape and shadow.
    /// - Returns: A configured `CAShapeLayer` with a white fill color and shadow properties.
    static func shadowlayerFor(path: UIBezierPath) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.white.cgColor
        layer.lineWidth = 0

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 3

        return layer
    }
}
