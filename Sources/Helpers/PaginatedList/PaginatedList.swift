//
//  PaginatedList.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 12.03.2024.
//

import Foundation

/// A struct that manages paginated lists of items. It handles adding new items,
/// tracking pagination information such as page size, page index, and determining if there are more pages.
public struct PaginatedList {

    /// The number of items per page. Defaults to `PaginatedList.defaultPageSize`.
    var pageSize: Int = PaginatedList.defaultPageSize

    /// The index of the current page, starting at 0.
    var pageIndex: Int = 0

    /// The list of items being paginated.
    var items: [AnyObject] = []

    /// A flag that indicates if there is a next page to load.
    var hasNextPage: Bool = false

    /// The ID of the last item in the list, used for pagination purposes.
    var lastItemId: Int?

    /// A computed property that checks if the current page has been fully loaded based on the unfiltered item count.
    var isCurrentPageLoaded: Bool {
        return unfilteredCount == (pageIndex + 1) * pageSize
    }

    /// An optional identifier for the paginated list.
    var identifier: String?

    /// The total count of items without filtering applied.
    var unfilteredCount: Int = 0

    /// Adds new items to the list and updates the unfiltered item count.
    /// - Parameter items: The items to add to the list.
    mutating func add(_ items: [AnyObject]) {
        add(items, unfilteredCount: items.count)
    }

    /// Adds filtered items to the list, updating the unfiltered count and determining if there is a next page.
    /// - Parameters:
    ///   - filteredItems: The filtered items to add to the list.
    ///   - unfilteredCount: The total count of unfiltered items.
    mutating func add(_ filteredItems: [AnyObject], unfilteredCount: Int) {
        self.items.append(contentsOf: filteredItems)
        self.unfilteredCount += unfilteredCount
        hasNextPage = unfilteredCount == pageSize
    }

    /// Sets the ID of the last item in the list.
    /// - Parameter lastItemId: The ID of the last item.
    mutating func setLastItemId(_ lastItemId: Int) {
        self.lastItemId = lastItemId
    }

    /// Resets the paginated list, clearing all items and resetting the pagination state.
    mutating func reset() {
        self.pageIndex = 0
        self.unfilteredCount = 0
        self.items = []
        self.hasNextPage = false
    }
}

/// A protocol for paginatable entities, which should have a total number of items, page size, and a list of items.
public protocol Paginatable {

    associatedtype Item: Codable

    var total: Int { get }
    var pageSize: Int { get }
    var items: [Item] { get }
}

extension PaginatedList {
    /// The default page size used by paginated lists.
    static var defaultPageSize: Int = 20
}
