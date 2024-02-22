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
        var contentConfiguration = cell.defaultContentConfiguration()
        
        let section = section(for: indexPath)
        switch (section, row) {
        case (_, .header(let title)):
            contentConfiguration.text = title
            
        case (.view, _):
            contentConfiguration.text = text(for: row)
            contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
            contentConfiguration.image = row.image
        
//        case(.edit, _):
            
        default:
            fatalError("Unexpected combination of section and row.")
        }
        
        cell.contentConfiguration = contentConfiguration
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
