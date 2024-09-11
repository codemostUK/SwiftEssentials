//
//  AttachableNavigationBar.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 11.09.2023.
//

import UIKit

/// A custom `UINavigationBar` subclass that allows additional views to be attached.
/// This can be used for adding custom views or configurations to the navigation bar.
class AttachableNavigationBar: UINavigationBar {

    // MARK: - View lifecycle

    /// Initializes the navigation bar programmatically and performs common setup.
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    /// Initializes the navigation bar from Interface Builder and performs common setup.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    /// A common initialization function that loads and attaches any custom views.
    func commonInit() {
        loadAndAttachView()
    }
}
