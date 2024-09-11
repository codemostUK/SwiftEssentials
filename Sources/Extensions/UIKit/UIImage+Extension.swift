//
//  UIImage+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 22.08.2024.
//

import Foundation
import UIKit

public extension UIImage {

    /// Combines two images vertically.
    ///
    /// This method combines two images into one vertically stacked image.
    /// - Parameters:
    ///   - left: The first image, drawn at the top.
    ///   - right: The second image, drawn below the first.
    /// - Returns: A new `UIImage` object combining the two images vertically, or `nil` if the operation fails.
    static func + (left: UIImage, right: UIImage) -> UIImage? {
        let totalHeight = left.size.height + right.size.height
        let width = max(left.size.width, right.size.width)

        // Start a new image context.
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: totalHeight), false, 0)

        // Draw the first image at the top.
        left.draw(at: CGPoint(x: 0, y: 0))

        // Draw the second image below the first.
        right.draw(at: CGPoint(x: 0, y: left.size.height))

        // Retrieve the combined image.
        let mergedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return mergedImage
    }

    /// Crops the image to the specified bounding box.
    ///
    /// This method crops the image to the given rectangle.
    /// - Parameter boundingBox: The rectangle to which the image should be cropped.
    /// - Returns: A new `UIImage` object cropped to the bounding box, or `nil` if cropping fails.
    func cropped(boundingBox: CGRect) -> UIImage? {
        guard let cgImage = self.cgImage?.cropping(to: boundingBox) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }

    /// Creates a new image filled with the specified color.
    ///
    /// This method generates a new image where the original image's shape is filled with the specified color.
    /// - Parameter color: The color to fill the image with.
    /// - Returns: A new `UIImage` object with the specified color applied, or `nil` if the operation fails.
    func imageWithColor(_ color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage else { return nil }

        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage)
        color.setFill()
        context.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
