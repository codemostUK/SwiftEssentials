//
//  URL+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import Foundation

public extension URL {

    /// Returns a dictionary of query items from the URL.
    /// - Returns: A dictionary where the query item names are keys and their values are the corresponding values.
    var queryItemsDictionary: [String: Any] {
        var dictionary = [String: Any]()
        let queryItems = URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems
        for queryItem in queryItems ?? [] {
            dictionary[queryItem.name] = queryItem.value
        }
        return dictionary
    }

    /// Returns a sanitized version of the URL with a default scheme ("http") if it doesn't have one.
    /// - Returns: The sanitized URL.
    var sanitise: URL {
        if var components = URLComponents(url: self, resolvingAgainstBaseURL: false) {
            if components.scheme == nil {
                components.scheme = "http"
            }
            return components.url ?? self
        }
        return self
    }

    /// Checks if the file size at the URL exceeds a 10 MB limit.
    /// - Returns: `true` if the file size exceeds 10 MB, `false` otherwise.
    var isFileSizeExeedsLimit: Bool {
        return self.isFileSizeExceedsLimit(10.0)
    }

    /// Checks if the file size at the URL exceeds a specified size limit in MB.
    /// - Parameter maxSizeInMB: The maximum allowed file size in MB.
    /// - Returns: `true` if the file size exceeds the specified limit, `false` otherwise.
    func isFileSizeExceedsLimit(_ maxSizeInMB: CGFloat) -> Bool {
        do {
            let resources = try resourceValues(forKeys: [.fileSizeKey])
            if let fileSize = resources.fileSize {
                let fileSizeInMB = Double(fileSize) / (1024.0 * 1024.0)
                return fileSizeInMB > maxSizeInMB
            }
        } catch {
            print("Failed to retrieve file size: \(error.localizedDescription)")
        }
        return false
    }
}
