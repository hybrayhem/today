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
        //* Content
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
