//
//  UIStackView+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 10.09.2023.
//

import UIKit

extension UIStackView {

    /// Removes all arranged subviews from the stack view.
    ///
    /// This method iterates over all arranged subviews and removes them from their superview.
    func clearContents() {
        self.arrangedSubviews.forEach {
            $0.removeFromSuperview() // Remove each subview from the stack view
        }
    }
}
