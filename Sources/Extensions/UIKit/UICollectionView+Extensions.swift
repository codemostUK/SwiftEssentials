//
//  UICollectionView+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 17.12.2023.
//

import Foundation
import UIKit

public extension UICollectionView {

    /// Registers a list of cell nibs for the collection view.
    /// - Parameter nibNames: The names of the nib files to register as cells.
    func registerCells(nibNames: [String]) {
        for nibName in nibNames {
            register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
        }
    }

    /// Registers a list of header nibs for the collection view.
    /// - Parameter nibNames: The names of the nib files to register as section headers.
    func registerHeaders(nibNames: [String]) {
        for nibName in nibNames {
            register(UINib(nibName: nibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: nibName)
        }
    }

    /// Registers a list of footer nibs for the collection view.
    /// - Parameter nibNames: The names of the nib files to register as section footers.
    func registerFooters(nibNames: [String]) {
        for nibName in nibNames {
            register(UINib(nibName: nibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: nibName)
        }
    }

    /// Registers cells, headers, and footers for the collection view.
    /// - Parameters:
    ///   - cells: An array of nib names for cells to register.
    ///   - headers: An optional array of nib names for headers to register.
    ///   - footers: An optional array of nib names for footers to register.
    func register(cells: [String]?, headers: [String]? = nil, footers: [String]? = nil) {
        if let cellNibs = cells {
            registerCells(nibNames: cellNibs)
        }
        if let headerNibs = headers {
            registerHeaders(nibNames: headerNibs)
        }
        if let footerNibs = footers {
            registerFooters(nibNames: footerNibs)
        }
    }

    func registerCell(_ type: UICollectionViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: identifier ?? cellId)
    }
}
