//
//  UIImageView+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 10.09.2023.
//

import UIKit

public extension UIImageView {

    /// Creates an animated `UIImageView` with a sequence of images named "Page 1" to "Page 24".
    /// - Returns: A configured `UIImageView` with animation set to repeat indefinitely.
    static func animatedImageView() -> UIImageView {
        let iw = UIImageView(frame: .init(x: 0, y: 0, width: 32, height: 32))
        var images: [UIImage] = []

        // Load images named "Page 1" to "Page 24" into the animation array.
        for i in 1...24 {
            images.append(UIImage(named: "Page \(i)")!)
        }

        iw.animationRepeatCount = 0 // Repeat animation indefinitely.
        iw.animationDuration = 1.2  // Animation duration in seconds.
        iw.animationImages = images  // Assign the loaded images for animation.

        return iw
    }

    /// A property that changes the color of the image view's image using tint color.
    /// - This property allows you to change the image's color by setting the `tintColor`.
    @IBInspectable
    var changeColor: UIColor? {
        get {
            // Retrieve the color from the image view's border color.
            guard let borderColor = layer.borderColor else { return nil }
            return UIColor(cgColor: borderColor)
        }
        set {
            // Apply the tint color to the image.
            let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
            self.image = templateImage
            self.tintColor = newValue
        }
    }
}
