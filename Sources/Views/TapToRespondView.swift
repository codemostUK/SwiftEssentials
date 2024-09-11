//
//  TapToRespondView.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 11.09.2023.
//

import UIKit

/// A custom `UIView` that triggers the first responder (e.g., a text field) when tapped.
/// This is useful for automatically focusing on a text field when the user taps anywhere within the view.
class TapToRespondView: UIView {

    /// An array of `UITextField` outlets that will respond to the tap gesture.
    @IBOutlet var firstResponders: [UITextField]!

    // MARK: - View lifecycle

    /// Initializes the view programmatically and sets up the tap gesture recognizer.
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    /// Initializes the view from Interface Builder and sets up the tap gesture recognizer.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    /// A common initialization function that adds the tap gesture recognizer to the view.
    private func commonInit() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
    }

    /// Handles the tap gesture and makes the first responder from the `firstResponders` array become active.
    /// - Parameter gestureRecognizer: The gesture recognizer detecting the tap.
    @objc private func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let textField = firstResponders.first else { return }
        textField.becomeFirstResponder()
    }
}
