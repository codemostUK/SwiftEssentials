//
//  UIAlertController+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 27.02.2024.
//

import Foundation
import UIKit

public extension UIAlertController {

    /// Fixes the issue of presenting an alert on iPads by setting the `sourceView` for popover presentation.
    /// - Parameter view: The view that should serve as the source for the popover presentation on iPad. If `nil`, the popover will not be adjusted.
    func fixIpad(for view: UIView?) {
        if UIDevice.current.userInterfaceIdiom != .phone {
            // Ensure the popoverPresentationController exists before modifying it.
            if self.responds(to: #selector(getter: UIViewController.popoverPresentationController)) {
                self.popoverPresentationController?.sourceView = view
            }
        }
    }
}
