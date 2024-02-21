//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String> // diffable
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String> // same generics with data source
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        // get reminder and fill into cell
        let reminder = Reminder.sampleData[indexPath.item]
        var contentConfiguration = cell.defaultContentConfiguration()
        
        // title
        contentConfiguration.text = reminder.title
        
        // secondary
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(
            forTextStyle: .caption1)
        
        cell.contentConfiguration = contentConfiguration
    }
}
