//
//  ReminderListViewController.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String> // diffable
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    var dataSource: DataSource! // implicitly unwrap DataSource
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init layout
        collectionView.collectionViewLayout = listLayout()
        
        // Init Data Source
        dataSource = makeDataSource()
        
        dataSource.apply(initialSnapshot()) // reflects the changes in UI

        collectionView.dataSource = dataSource
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }

    private func makeDataSource() -> DataSource {
        // Create cell config
        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            
            // get reminder and assign to cell
            let reminder = Reminder.sampleData[indexPath.item]
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = reminder.title
            cell.contentConfiguration = contentConfiguration
        }
        
        // Create data source
        return DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            
            // dequeue and return a cell using the cell registration
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }
    }
    
    private func initialSnapshot() -> Snapshot {
        // create empty snaphot
        var snapshot = Snapshot()
        snapshot.appendSections([0]) // adding single section
        var reminderTitles = Reminder.sampleData.map { $0.title }
        snapshot.appendItems(reminderTitles) // add titles as snaphot items
        
        return snapshot
    }
    
}

