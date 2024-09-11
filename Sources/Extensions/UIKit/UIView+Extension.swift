//
//  UIView+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 15.08.2024.
//

import UIKit

extension UIView {

    /// The corner radius applied to the view's layer.
    ///
    /// Setting this property updates the layer's corner radius and ensures the view's contents are clipped to the bounds.
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
            self.setNeedsDisplay()
        }
    }

    /// A boolean indicating if the top-left corner of the view is rounded.
    ///
    /// Setting this property rounds or unrounds the top-left corner of the view.
    @IBInspectable var topLeft: Bool {
        get { return layer.maskedCorners.contains(.layerMinXMinYCorner) }
        set {
            if newValue {
                layer.maskedCorners.insert(.layerMinXMinYCorner)
            } else {
                layer.maskedCorners.remove(.layerMinXMinYCorner)
            }
        }
    }

    /// A boolean indicating if the top-right corner of the view is rounded.
    ///
    /// Setting this property rounds or unrounds the top-right corner of the view.
    @IBInspectable var topRight: Bool {
        get { return layer.maskedCorners.contains(.layerMaxXMinYCorner) }
        set {
            if newValue {
                layer.maskedCorners.insert(.layerMaxXMinYCorner)
            } else {
                layer.maskedCorners.remove(.layerMaxXMinYCorner)
            }
        }
    }

    /// A boolean indicating if the bottom-left corner of the view is rounded.
    ///
    /// Setting this property rounds or unrounds the bottom-left corner of the view.
    @IBInspectable var bottomLeft: Bool {
        get { return layer.maskedCorners.contains(.layerMinXMaxYCorner) }
        set {
            if newValue {
                layer.maskedCorners.insert(.layerMinXMaxYCorner)
            } else {
                layer.maskedCorners.remove(.layerMinXMaxYCorner)
            }
        }
    }

    /// A boolean indicating if the bottom-right corner of the view is rounded.
    ///
    /// Setting this property rounds or unrounds the bottom-right corner of the view.
    @IBInspectable var bottomRight: Bool {
        get { return layer.maskedCorners.contains(.layerMaxXMaxYCorner) }
        set {
            if newValue {
                layer.maskedCorners.insert(.layerMaxXMaxYCorner)
            } else {
                layer.maskedCorners.remove(.layerMaxXMaxYCorner)
            }
        }
    }

    /// A boolean indicating if the view should be circular.
    ///
    /// Setting this property adjusts the corner radius to make the view circular based on its height.
    @IBInspectable var isCirclular: Bool {
        get {
            return layer.cornerRadius == bounds.height / 2
        }
        set {
            if newValue {
                self.cornerRadius = bounds.height / 2
            }
        }
    }

    /// A boolean indicating if the view should have a shadow.
    ///
    /// Setting this property adds or removes a shadow effect based on the view's layer's corner radius.
    @IBInspectable var shadow: Bool {
        get {
            return true
        }
        set {
            if newValue {
                layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 0)
                layer.shadowOpacity = 0.2
                layer.shadowRadius = 3
                layer.masksToBounds = false
            } else {
                layer.shadowPath = nil
            }
        }
    }

    /// A boolean indicating if the view should have a circular shadow.
    ///
    /// Setting this property applies a circular shadow effect if the view is already circular.
    @IBInspectable var shadowCircle: Bool {
        get {
            return self.isCirclular
        }
        set {
            if newValue {
                self.isCirclular = true
                let shadowView = UIView(frame: self.frame)
                shadowView.clipsToBounds = false
                shadowView.layer.cornerRadius = bounds.height / 2
                shadowView.layer.insertSublayer(CAShapeLayer.shadowlayerFor(path: UIBezierPath.circlePathFor(radius: shadowView.frame.size.width / 2)), at: 0)

                if let superView = self.superview {
                    superView.insertSubview(shadowView, belowSubview: self)
                }
            }
        }
    }

    /// A boolean indicating if the view is visible.
    ///
    /// Setting this property hides or shows the view.
    var visible: Bool {
        get {
            return !self.isHidden
        }
        set {
            self.isHidden = !newValue
        }
    }

    /// A boolean indicating if the view is visible and opaque.
    ///
    /// Setting this property shows or hides the view and adjusts its alpha to be fully opaque or fully transparent.
    var visibleAndOpaque: Bool {
        get {
            return !self.isHidden && self.alpha == 1
        }
        set {
            self.isHidden = !newValue
            self.alpha = newValue ? 1 : 0
        }
    }

    /// Creates a gradient background for the view.
    ///
    /// - Parameters:
    ///   - colors: An array of `CGColor` objects to use for the gradient.
    ///   - startPoint: The start point of the gradient (defaults to `.zero`).
    ///   - endPoint: The end point of the gradient (defaults to `(1, 0)`).
    /// - Returns: The created `CAGradientLayer`.
    @discardableResult
    func createGradientBackground(for colors: [CGColor?], startPoint: CGPoint = .zero, endPoint: CGPoint = CGPoint(x: 1, y: 0)) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = colors as [Any]
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }

    /// Removes all gradient layers from the view.
    func removeGradientLayers() {
        self.layer.sublayers?.forEach {
            if let gradientLayer = $0 as? CAGradientLayer {
                gradientLayer.removeFromSuperlayer()
            }
        }
    }

    /// Creates a gradient overlay for a given frame.
    ///
    /// - Parameter frame: The frame for the gradient overlay.
    /// - Returns: The created `CAGradientLayer`.
    static func createGradientOverlay(_ frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.locations = [0, 0.4]
        gradientLayer.colors = [UIColor(red: 21/255.0, green: 21/255.0, blue: 21/255.0, alpha: 0.7).cgColor,
                           UIColor(red: 23/255.0, green: 23/255.0, blue: 23/255.0, alpha: 0.3).cgColor,
                           UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor]
        gradientLayer.frame = frame
        return gradientLayer
    }

    /// Adds a width constraint to the view.
    ///
    /// - Parameter value: The width value for the constraint.
    func addConstraintForWidth(_ value: CGFloat) {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: value)
        self.addConstraint(constraint)
    }

    /// Adds a height constraint to the view.
    ///
    /// - Parameter value: The height value for the constraint.
    /// - Returns: The created `NSLayoutConstraint`.
    func addConstraintForHeight(_ value: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: value)
        self.addConstraint(constraint)
        return constraint
    }

    /// Removes the view from its containing stack view.
    func removeFromSuperStackView() {
        if let superview = superview as? UIStackView {
            superview.removeArrangedSubview(self)
            NSLayoutConstraint.deactivate(self.constraints)
            self.removeFromSuperview()
        }
    }

    /// Loads a view from a nib file and pins it to the edges of the current view.
    func loadAndPinView() {
        let view = loadNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}

extension UIView {

    /// Returns PNG data representation of the view with an optional fill color.
    ///
    /// - Parameter fillColor: The color to fill the view's background.
    /// - Returns: PNG data of the view or `nil` if unable to create.
    func pngData(with fillColor: UIColor = .clear) -> Data? {
        // Start an image context with the size of the view.
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        // Set the fill color and fill the view's bounds.
        context.setFillColor(fillColor.cgColor)
        context.fill(self.bounds)

        // Render the view's layer into the current image context.
        self.layer.render(in: context)

        // Get the image from the current image context.
        let image = UIGraphicsGetImageFromCurrentImageContext()

        // End the image context to free up resources.
        UIGraphicsEndImageContext()

        // Return the PNG data of the image.
        return image?.pngData()
    }
}

extension UIView {

    /// Captures a snapshot of the view within an optional frame and fill color.
    ///
    /// - Parameters:
    ///   - frame: The frame of the snapshot.
    ///   - fillColor: The color to fill the view's background.
    /// - Returns: The captured `UIImage` or `nil` if unable to create.
    func snapshot(frame: CGRect? = nil, fillColor: UIColor = .clear) -> UIImage? {
        // Begin an image context with the specified frame size.
        let rect = frame ?? self.bounds
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)

        // Draw the view's hierarchy into the current image context.
        self.drawHierarchy(in: rect, afterScreenUpdates: true)

        // Get the current image context.
        if let context = UIGraphicsGetCurrentContext() {
            // Translate the context to match the view's bounds.
            context.translateBy(x: -rect.origin.x, y: -rect.origin.y)
            context.setFillColor(fillColor.cgColor)
            context.fill(rect)

            // Render the view's layer into the context.
            self.layer.render(in: context)
        }

        // Capture the image from the current image context.
        let image = UIGraphicsGetImageFromCurrentImageContext()

        // End the image context to free up resources.
        UIGraphicsEndImageContext()

        // Return the captured image.
        return image
    }

    // Returns the safe area insets of the view, or zero if not available.
    var safeAreaInset: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets
        } else {
            return .zero
        }
    }

    // Applies a continuous rotation animation to the view.
    func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }

    // Loads a nib file with the same name as the view and returns the loaded view.
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }

    // Loads and attaches the view from the nib to the current view.
    func loadAndAttachView() {
        let view = loadNib()

        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }

    // Rounds the specified corners of the view with the given radius.
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    // Applies a drop shadow to the view with the specified parameters.
    func applyDropShadow(_ color: UIColor = .black, opacity: Float = 0.5, offSet: CGSize = CGSize(width: -1, height: 1), radius: CGFloat = 5, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    // Animates a shake effect on the view with the given duration and impact multiplier.
    func animateShake(withDuration duration: TimeInterval = 0.5, impactMultiplier: Int = 1) {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.duration = duration
        shakeAnimation.values = [-10 * impactMultiplier, 10 * impactMultiplier, -5 * impactMultiplier, 5 * impactMultiplier, 0]
        shakeAnimation.beginTime = CACurrentMediaTime()
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)

        self.layer.add(shakeAnimation, forKey: "shake")
    }
}
