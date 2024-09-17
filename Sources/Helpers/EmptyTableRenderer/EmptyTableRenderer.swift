//
//  EmptyTableRenderer.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import Foundation
import UIKit

/// Delegate protocol for handling actions in an empty table view.
public protocol EmptyTableRendererDelegate: NSObjectProtocol {
    func didRequestNewItem()
}

/// Protocol for a table view cell used by `EmptyTableRenderer`. The cell must conform to `FixedHeight`.
public protocol EmptyTableRendererCellDelegate: UITableViewCell, FixedHeight {}

/// An open class for rendering a table view with an empty state using a specific cell type.
open class EmptyTableRenderer: NSObject {

    public var emptyCellClass: EmptyTableRendererCellDelegate.Type
    public var emptyCellData: AnyObject?
    public var tableView: UITableView
    public weak var delegate: EmptyTableRendererDelegate?

    /// Initializes the `EmptyTableRenderer` with the required cell class and table view.
    /// - Parameters:
    ///   - emptyCellClass: The class of the cell to display when the table is empty.
    ///   - emptyCellData: Optional data to pass to the empty cell.
    ///   - tableView: The table view to render.
    ///   - delegate: An optional delegate to handle user interactions.
    public init(emptyCellClass: EmptyTableRendererCellDelegate.Type, emptyCellData: AnyObject? = nil, tableView: UITableView, delegate: EmptyTableRendererDelegate? = nil) {
        self.emptyCellClass = emptyCellClass
        self.emptyCellData = emptyCellData
        self.tableView = tableView
        self.delegate = delegate
    }

    /// Renders the empty table view with the specified empty cell.
    public func render() {
        tableView.register(cells: [emptyCellClass.identifier], headerFooterViews: nil)
        tableView.setContentOffset(tableView.contentOffset, animated: false)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        tableView.isScrollEnabled = false
    }
}

// MARK: - UITableViewDataSource
extension EmptyTableRenderer: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: emptyCellClass.identifier, for: indexPath)
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: UIView?) -> UIView? {
        return UIView()
    }
}

// MARK: - UITableViewDelegate
extension EmptyTableRenderer: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let emptyCellClass = self.emptyCellClass as? VariableHeight.Type,
           let data = self.emptyCellData {
            return emptyCellClass.heightForData(data, isLastItem: false)
        }
        return emptyCellClass.height
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let delegate = self.delegate, let cell = cell as? DelegateSettable {
            cell.delegate = delegate
        }
        if let data = self.emptyCellData, let cell = cell as? DataSettable {
            cell.data = data
        }
    }
}
