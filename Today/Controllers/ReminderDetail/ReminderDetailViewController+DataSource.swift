//
//  ReminderDetailViewController+DataSource.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

extension ReminderDetailViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    
    func makeDataSource() -> DataSource {
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        return DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
    
    private func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        
        switch (section, row) {
        case (_, .header(let title)):
            cell.contentConfiguration = headerConfiguration(for: cell, title: title)
            
        case (.view, _):
            cell.contentConfiguration = defaultConfiguration(for: cell, at: row)
            
        case (.title, .editableText(let title)):
            cell.contentConfiguration = titleConfiguration(for: cell, with: title)
            
        case (.date, .editableDate(let date)):
            cell.contentConfiguration = dateConfiguration(for: cell, with: date)
            
        case (.notes, .editableText(let notes)):
            cell.contentConfiguration = notesConfiguration(for: cell, with: notes)
            
        default:
            fatalError("Unexpected combination of section and row.")
        }
        
        cell.tintColor = .todayPrimaryTint
    }
        
    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section // In view mode, all items are displayed in section 0. In editing mode, the title, date, and notes are separated into sections.
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }
}
