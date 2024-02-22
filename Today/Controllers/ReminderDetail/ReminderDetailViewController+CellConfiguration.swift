//
//  ReminderDetailViewController+CellConfiguration.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

extension ReminderDetailViewController {
    func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        
        return contentConfiguration
    }
    
    func headerConfiguration(for cell: UICollectionViewListCell, title: String) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        
        contentConfiguration.text = title
        
        return contentConfiguration
    }
}
