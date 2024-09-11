//
//  AttachableView.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 11.09.2023.
//

import UIKit

/// A custom `UIView` subclass that allows additional views to be attached.
/// This can be used to load and attach custom views within the view's hierarchy.
class AttachableView: UIView {

    // MARK: - View lifecycle

    /// Initializes the view programmatically and performs common setup.
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    /// Initializes the view from Interface Builder and performs common setup.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    /// A common initialization function that loads and attaches any custom views.
    func commonInit() {
        loadAndAttachView()
    }
}
