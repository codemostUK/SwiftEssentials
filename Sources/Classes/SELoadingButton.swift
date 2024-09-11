//
//  SELoadingButton.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 22.03.2023.
//

import UIKit

/// A UIButton subclass that shows a loading indicator when active.
public class SELoadingButton: UIButton {

    private var activityIndicator: UIActivityIndicatorView?

    /// Enum to define the possible positions of the loading indicator.
    enum IndicatorPosition {
        case left
        case middle
        case right
    }

    /// The position of the loading indicator relative to the button's title.
    var indicatorPosition: IndicatorPosition = .middle

    /// The color of the loading indicator.
    @IBInspectable var indicatorColor: UIColor = .gray {
        didSet {
            activityIndicator?.color = indicatorColor
        }
    }

    /// Shows a loading indicator on the button and disables the button.
    public func showLoading() {
        // Initialize the activity indicator if it hasn't been created yet.
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView()
            activityIndicator?.hidesWhenStopped = true
            activityIndicator?.color = indicatorColor

            // Add the activity indicator as a subview and set up its constraints.
            self.addSubview(activityIndicator!)
            setupConstraints()
        }
        // Start animating the activity indicator and disable the button.
        activityIndicator?.startAnimating()
        self.isEnabled = false
    }

    /// Hides the loading indicator and enables the button.
    public func hideLoading() {
        // Stop animating the activity indicator and enable the button.
        activityIndicator?.stopAnimating()
        self.isEnabled = true
    }

    /// Sets up the constraints for positioning the loading indicator.
    private func setupConstraints() {
        activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        var horizontalConstraint: NSLayoutConstraint

        // Position the activity indicator based on the specified position.
        switch indicatorPosition {
        case .left:
            horizontalConstraint = NSLayoutConstraint(item: self.titleLabel ?? self, attribute: .leading, relatedBy: .equal, toItem: activityIndicator, attribute: .trailing, multiplier: 1, constant: 0)
        case .middle:
            horizontalConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        case .right:
            horizontalConstraint = NSLayoutConstraint(item: self.titleLabel ?? self, attribute: .trailing, relatedBy: .equal, toItem: activityIndicator, attribute: .leading, multiplier: 1, constant: 0)
        }
        self.addConstraint(horizontalConstraint)

        // Center the activity indicator vertically within the button.
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}
