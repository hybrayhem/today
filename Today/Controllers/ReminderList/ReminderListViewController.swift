//
//  ReminderListViewController.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    var dataSource: DataSource! // implicitly unwrap DataSource
    var reminders: [Reminder] = Reminder.sampleData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init layout
        collectionView.collectionViewLayout = listLayout()
        
        // Init Data Source
        dataSource = makeDataSource()
        
        updateSnapshot() // reflects the changes in UI

        collectionView.dataSource = dataSource
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    func updateSnapshot() {
        // create empty snaphot
        var snapshot = Snapshot()
        snapshot.appendSections([0]) // adding single section
        let reminderTitles = reminders.map { $0.id }
        snapshot.appendItems(reminderTitles) // add titles as snaphot items
        
        dataSource.apply(snapshot)
    }
}

