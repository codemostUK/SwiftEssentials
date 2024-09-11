//
//  SEUIView.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 22.03.2023.
//
import UIKit

/// A `UIView` subclass with additional functionality for setting corner radius, border, and shadow properties using Interface Builder attributes.
final public class SEUIView: UIView {
    
    /// The color of the view's border. Setting this value will update the layer's border color.
    @IBInspectable public var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    /// The width of the view's border. This value is applied to the layer's border width property.
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
        
    /// The color of the view's shadow. Setting this value will update the layer's shadow color.
    @IBInspectable public var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    /// The offset of the view's shadow. Setting this value will update the layer's shadow offset.
    @IBInspectable public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = .zero
        }
    }

    /// The opacity of the view's shadow. This value ranges from 0.0 (completely transparent) to 1.0 (completely opaque).
    @IBInspectable public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    /// The radius of the view's shadow blur. This value controls how much the shadow is spread.
    @IBInspectable public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    /// A Boolean value that determines whether the view's layer masks its bounds. If `true`, subviews are clipped to the layer’s bounds.
    @IBInspectable public var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
}
