//
//  UITableView+Extensions.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 11.06.2024.
//

import Foundation
import UIKit

public extension UITableView {

    /// Adds or removes padding at the top of the table view.
    @IBInspectable var topPadding: CGFloat {
        get {
            return contentInset.top
        }
        set {
            contentInset = UIEdgeInsets(top: newValue, left: 0, bottom: contentInset.bottom, right: 0)
        }
    }

    /// Adds or removes safe area padding at the bottom of the table view.
    ///
    /// This property adjusts the `contentInset` based on the safe area insets.
    @IBInspectable var requiresSafeAreaBottomPadding: Bool {
        get {
            return contentInset.bottom == 0
        }
        set {
            if newValue {
                contentInset = UIEdgeInsets(top: contentInset.top, left: 0, bottom: UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0, right: 0)
            } else {
                contentInset = UIEdgeInsets(top: contentInset.top, left: 0, bottom: 0, right: 0)
            }
        }
    }

    /// Registers cells and header/footer views using their nib names.
    ///
    /// - Parameters:
    ///   - cells: The list of nib names for the cells to register.
    ///   - headerFooterViews: The list of nib names for the header/footer views to register.
    func register(cells: [String]?, headerFooterViews: [String]?) {
        if let cellNibs = cells {
            registerCells(nibNames: cellNibs)
        }
        if let headerFooterViews = headerFooterViews {
            registerHeaderFooterViews(nibNames: headerFooterViews)
        }
    }

    /// Registers a list of cells using their nib names.
    ///
    /// - Parameter nibNames: The list of nib names for the cells to register.
    func registerCells(nibNames: [String]) {
        for nibName in nibNames {
            register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        }
    }

    /// Registers a list of header/footer views using their nib names.
    ///
    /// - Parameter nibNames: The list of nib names for the header/footer views to register.
    func registerHeaderFooterViews(nibNames: [String]) {
        for nibName in nibNames {
            register(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: nibName)
        }
    }

    /// Registers a cell with a specific type and identifier.
    ///
    /// - Parameters:
    ///   - type: The type of cell to register.
    ///   - identifier: An optional identifier for the cell. Defaults to the cell type name.
    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: identifier ?? cellId)
    }

    /// Creates a footer view with a loading indicator.
    ///
    /// - Parameter size: The size of the footer view. If `nil`, defaults to a width matching the table view and a height of 100 points.
    /// - Returns: A `UIView` containing a `UIActivityIndicatorView`.
    func footerLoadingView(_ size: CGSize?) -> UIView {
        let footerSize = (size != nil) ? size : CGSize(width: frame.size.width, height: 100)
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: footerSize!.width, height: footerSize!.height))
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = footerView.center
        footerView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        return footerView
    }

    /// Scrolls to the first row of the table view.
    func scrollToFirstRow() {
        guard numberOfSections > 0, numberOfRows(inSection: 0) > 0 else { return }
        self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .middle, animated: true)
    }

    /// Scrolls to the last row of the table view.
    ///
    /// - Parameter animated: A boolean indicating whether the scrolling should be animated. Default is `false`.
    func scrollToLastRow(animated: Bool = false) {
        guard numberOfSections > 0, numberOfRows(inSection: 0) > 0 else { return }
        let numberOfSections = self.numberOfSections
        let numberOfRowsLastSection = numberOfRows(inSection: numberOfSections - 1)
        self.scrollToRow(at: IndexPath(row: numberOfRowsLastSection - 1, section: numberOfSections - 1), at: .middle, animated: animated)
    }
}
