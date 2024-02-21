//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID> // diffable
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID> // same generics with data source
    
    func makeDataSource() -> DataSource {
        // Create cell config
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        // Create data source
        return DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
            
            // dequeue and return a cell using the cell registration
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }
    }
    
    func initialSnapshot() -> Snapshot {
        // create empty snaphot
        var snapshot = Snapshot()
        snapshot.appendSections([0]) // adding single section
        let reminderTitles = reminders.map { $0.title }
        snapshot.appendItems(reminderTitles) // add titles as snaphot items
        
        return snapshot
    }
    
    private func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        //* Content
        // get reminder and fill into cell
        let reminder = reminders.reminder(withId: id)
//        let reminder = reminders[indexPath.item]
        var contentConfiguration = cell.defaultContentConfiguration()
        
        // title
        contentConfiguration.text = reminder.title
        
        // secondary
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(
            forTextStyle: .caption1)
        
        cell.contentConfiguration = contentConfiguration
        
        //* Accessories
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        
        cell.accessories = [
            .customView(
                configuration: doneButtonConfiguration
            ), .disclosureIndicator(displayed: .always) // indicate navigation
        ]
        
        //* Background
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration
    }

    private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        // image
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        
        // button
        let button = UIButton()
        button.setImage(image, for: .normal)
        
        return UICellAccessory.CustomViewConfiguration(
            customView: button, placement: .leading(displayed: .always))
    }
}
