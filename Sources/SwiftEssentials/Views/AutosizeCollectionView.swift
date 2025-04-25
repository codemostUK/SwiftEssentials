//
//  AutosizeCollectionView.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 11.09.2023.
//

import UIKit

/// A `UICollectionView` subclass that automatically adjusts its size based on its content size.
/// This is useful for cases where the collection view needs to dynamically resize to fit its content.
open class AutosizeCollectionView: UICollectionView {

    /// Called when the view’s layout is being updated.
    /// Invalidates the intrinsic content size if the collection view's bounds change.
    public override func layoutSubviews() {
        super.layoutSubviews()

        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }

    /// Returns the content size of the collection view, allowing it to auto-resize.
    public override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}
