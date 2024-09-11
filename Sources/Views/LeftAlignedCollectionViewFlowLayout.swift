//
//  LeftAlignedCollectionViewFlowLayout.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 11.09.2023.
//

import UIKit

/// A custom `UICollectionViewFlowLayout` that aligns items to the left within a collection view.
/// It adjusts the `x` position of each item to ensure they are aligned to the left,
/// while respecting section insets and inter-item spacing.
class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    /// Initializes the layout with predefined section insets and spacing.
    override init() {
        super.init()
        sectionInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        minimumLineSpacing = 5
        minimumInteritemSpacing = 10
    }

    /// Required initializer when decoding from Interface Builder (not implemented here).
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Returns the layout attributes for all items in the specified rectangle.
    /// Adjusts the `x` position of items to align them to the left within the collection view's bounds.
    /// - Parameter rect: The rectangle (in the collection view's coordinate system) that defines the area for which layout attributes are needed.
    /// - Returns: An array of `UICollectionViewLayoutAttributes` objects representing the layout attributes for all the cells and views in the specified rectangle.
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0

        attributes?.forEach { layoutAttribute in
            // Reset left margin when starting a new row
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            // Adjust the item's x position to the current left margin
            layoutAttribute.frame.origin.x = leftMargin

            // Update the left margin for the next item
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }

        return attributes
    }
}
