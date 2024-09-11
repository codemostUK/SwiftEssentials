//
//  GenericTableDataSource.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import UIKit

/// Protocol defining the data required for table view rendering.
protocol TableData {

    /// Registers the cells and header/footer views that the table view will use.
    /// - Returns: A tuple containing an array of cell identifiers and an array of header/footer view identifiers to register.
    func itemsToRegister() -> (cells: [String]?, headerFooterViews: [String]?)

    /// Returns the class type for the cell at the specified index path.
    /// - Parameter indexPath: The index path of the cell.
    /// - Returns: The `UITableViewCell` class to be used for the specified index path.
    func cellClassAt(_ indexPath: IndexPath) -> UITableViewCell.Type

    /// Checks if the delegate conforms to the necessary protocol for interaction.
    /// - Parameter delegate: The delegate object to check.
    /// - Returns: `true` if the delegate conforms, `false` otherwise.
    func isConforming(_ delegate: Any?) -> Bool

    /// Returns the class type for the header or footer view in the specified section.
    /// - Parameters:
    ///   - section: The section index.
    ///   - isHeader: A boolean indicating if the request is for a header (`true`) or a footer (`false`).
    /// - Returns: The `UITableViewHeaderFooterView` class to be used for the header/footer, or `nil` if none is provided.
    func headerFooterViewClassAt(_ section: Int, isHeader: Bool) -> UITableViewHeaderFooterView.Type?

    /// Returns the number of sections in the table view.
    /// - Returns: The number of sections.
    func numberOfSections() -> Int

    /// Returns the number of rows in the specified section.
    /// - Parameter section: The section index.
    /// - Returns: The number of rows in the section.
    func numberOfRowsAt(_ section: Int) -> Int

    /// Returns the data for the cell at the specified index path.
    /// - Parameter indexPath: The index path of the cell.
    /// - Returns: The data object for the cell, or `nil` if there is no data.
    func dataAt(_ indexPath: IndexPath) -> AnyObject?

    /// Returns the data for the header or footer at the specified section.
    /// - Parameters:
    ///   - section: The section index.
    ///   - isHeader: A boolean indicating if the request is for a header (`true`) or a footer (`false`).
    /// - Returns: The data object for the header/footer, or `nil` if there is no data.
    func dataAt(_ section: Int, isHeader: Bool) -> AnyObject?

    /// Checks if the cell at the specified index path is the last item in the section.
    /// - Parameter indexPath: The index path of the cell.
    /// - Returns: `true` if the cell is the last item in the section, `false` otherwise.
    func isLastItemAt(_ indexPath: IndexPath) -> Bool

    /// Returns the data for the last item in the table view.
    /// - Returns: The data object for the last item, or `nil` if there is no data.
    func dataAtLastIndexPath() -> AnyObject?
}

extension TableData {

    func isConforming(_ delegate: Any?) -> Bool { true }
    
    func headerFooterViewClassAt(_ section: Int, isHeader: Bool) -> UITableViewHeaderFooterView.Type? { nil }
    
    func numberOfSections() -> Int { 1 }
    
    func dataAt(_ section: Int, isHeader: Bool) -> AnyObject? { nil }

    /// Returns the data for the last item in the table view.
    /// - Returns: The data object for the last item, or `nil` if there is no data.
    func dataAtLastIndexPath() -> AnyObject? {
        guard numberOfSections() - 1 > 0,
              numberOfRowsAt(numberOfSections() - 1) - 1 > 0
        else { return nil }
        
        let lastSection = numberOfSections() - 1
        let lastRow = numberOfRowsAt(lastSection) - 1
        let lastIndexPath = IndexPath(row: lastRow, section: lastSection)
        return dataAt(lastIndexPath)
    }
}

//MARK: - Renderer
protocol TableDataRendererDelegate: NSObjectProtocol {
    func didSelectRowAt(_ indexPath: IndexPath)
    func didDeSelectRowAt(_ indexPath: IndexPath)
}

extension TableDataRendererDelegate {
    func didDeSelectRowAt(_ indexPath: IndexPath) { }
}

class TableDataRenderer: NSObject {
    var tableData: TableData
    weak var delegate: NSObjectProtocol?
    weak var tableView: UITableView?
    
    init?(tableData: TableData, tableView: UITableView, delegate: NSObjectProtocol? = nil) {
        guard tableData.isConforming(delegate) else { return nil }
        self.tableData = tableData
        self.delegate = delegate
        self.tableView = tableView
        super.init()
        
        let registerItems = tableData.itemsToRegister()
        tableView.register(cells: registerItems.cells, headerFooterViews: registerItems.headerFooterViews)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = true
        tableView.isScrollEnabled = true
        tableView.reloadData()
    }
    
    func updateData(_ tableData: TableData) {
        self.tableData = tableData
        let registerItems = tableData.itemsToRegister()
        tableView?.register(cells: registerItems.cells, headerFooterViews: registerItems.headerFooterViews)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.isUserInteractionEnabled = true
        tableView?.isScrollEnabled = true
        tableView?.reloadData()
    }
}

extension TableDataRenderer: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cellType = tableData.cellClassAt(indexPath) as? VariableHeight.Type {
            return cellType.heightForData(tableData.dataAt(indexPath), isLastItem: tableData.isLastItemAt(indexPath))
        } else if let cellType = tableData.cellClassAt(indexPath) as? FixedHeight.Type {
            return cellType.height
        }
        return 44.0 //APPLE default height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? LastMarkable {
            cell.isLastItem = tableData.isLastItemAt(indexPath)
        }
        
        if let cell = cell as? DelegateSettable {
            cell.delegate = delegate
        }
        
        if let cell = cell as? DataSettable {
            cell.data = tableData.dataAt(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = delegate as? TableDataRendererDelegate else { return }
        delegate.didSelectRowAt(indexPath)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let delegate = delegate as? TableDataRendererDelegate else { return }
        delegate.didDeSelectRowAt(indexPath)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let headerViewType = tableData.headerFooterViewClassAt(section, isHeader: true) as? VariableHeight.Type {
            return headerViewType.heightForData(tableData.dataAt(section, isHeader: true), isLastItem: false)
        }
        if let headerViewType = tableData.headerFooterViewClassAt(section, isHeader: true) as? FixedHeight.Type {
            return headerViewType.height
        }
        return .zero
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let identifier = tableData.headerFooterViewClassAt(section, isHeader: true)?.identifier {
            return tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? DataSettable {
            view.data = tableData.dataAt(section, isHeader: true)
        }
        
        if let view = view as? DelegateSettable {
            view.delegate = delegate
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let identifier = tableData.headerFooterViewClassAt(section, isHeader: false)?.identifier {
            return tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let view = view as? DataSettable {
            view.data = tableData.dataAt(section, isHeader: false)
        }
        if let view = view as? DelegateSettable {
            view.delegate = delegate
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let footerViewType = tableData.headerFooterViewClassAt(section, isHeader: false) as? FixedHeight.Type {
            return footerViewType.height
        }
        return .zero
    }
}

// MARK: - <UITableViewDataSource>
extension TableDataRenderer: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.numberOfRowsAt(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: tableData.cellClassAt(indexPath).identifier, for: indexPath)
    }
}
