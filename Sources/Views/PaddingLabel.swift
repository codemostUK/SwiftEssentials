//
//  PaddingLabel.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 10.09.2023.
//

import UIKit

/// A `UILabel` subclass that allows for padding to be added around the text.
/// Padding is applied on all sides (top, bottom, left, and right), which makes it useful for labels that need extra spacing inside their bounds.
final class PaddingLabel: UILabel {

    /// The padding inset for the top of the label.
    @IBInspectable var topInset: CGFloat = 5.0

    /// The padding inset for the bottom of the label.
    @IBInspectable var bottomInset: CGFloat = 5.0

    /// The padding inset for the left side of the label.
    @IBInspectable var leftInset: CGFloat = 7.0

    /// The padding inset for the right side of the label.
    @IBInspectable var rightInset: CGFloat = 7.0

    /// Overrides the default `drawText(in:)` method to apply padding around the text.
    /// - Parameter rect: The rectangle in which the text will be drawn.
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    /// Overrides the intrinsic content size to account for the padding insets.
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    /// Updates the preferred maximum layout width when the label's bounds change, ensuring the label works properly in stack views.
    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}
