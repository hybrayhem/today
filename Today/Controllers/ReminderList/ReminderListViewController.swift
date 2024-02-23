//
//  ReminderListViewController.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID> // same generics with data source
    
    var dataSource: DataSource! // implicitly unwrap DataSource
    var reminders: [Reminder] = Reminder.sampleData
    var listStyle: ReminderListStyle = .today
    var filteredReminders: [Reminder] {
        return reminders.filter { listStyle.shouldInclude(date: $0.dueDate) }.sorted {
            $0.dueDate < $1.dueDate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init layout
        collectionView.collectionViewLayout = listLayout()
        
        // Add 'add' button
        initAddButton()
        
        initSegmentedControl()
        
        // Init Data Source
        dataSource = makeDataSource()
        
        updateSnapshot() // reflects the changes in UI

        collectionView.dataSource = dataSource
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    private func initSegmentedControl() {
        let listStyleSegmentedControl = UISegmentedControl(items: [
            ReminderListStyle.today.name, ReminderListStyle.future.name, ReminderListStyle.all.name
        ])
        
        listStyleSegmentedControl.selectedSegmentIndex = listStyle.rawValue
        listStyleSegmentedControl.addTarget(self, action: #selector(didChangeListStyle(_:)), for: .valueChanged)
        
        navigationItem.titleView = listStyleSegmentedControl
    }
    
    private func initAddButton() {
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didPressAddButton(_:))
        )
        addButton.accessibilityLabel = NSLocalizedString(
            "Add reminder",
            comment: "Add button accessibility label"
        )
        
        navigationItem.rightBarButtonItem = addButton
        if #available(iOS 16, *) {
            navigationItem.style = .navigator
        }
    }
    
    private func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath, let id = dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }
        
        let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) {
            [weak self] _, _, completion in
            self?.reminders.delete(withId: id)
            self?.updateSnapshot()
            completion(false)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func updateSnapshot(reloading idsThatChanged: [Reminder.ID] = []) {
        let ids = idsThatChanged.filter { id in filteredReminders.contains(where: { $0.id == id }) }
        
        var snapshot = Snapshot()
        snapshot.appendSections([0]) // adding single section
        let reminderIds = filteredReminders.map { $0.id }
        snapshot.appendItems(reminderIds) // add titles as snaphot items
        
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
    }
}
