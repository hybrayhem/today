//
//  ReminderDetailViewController.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

class ReminderDetailViewController: UICollectionViewController {
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    var reminder: Reminder
    private var dataSource: DataSource!
    
    init(reminder: Reminder) {
        self.reminder = reminder

        let listLayout = ReminderDetailViewController.listLayout()
        super.init(collectionViewLayout: listLayout)
    }

    required init?(coder: NSCoder) {
        fatalError("Always initialize ReminderDetailViewController using init(reminder:)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 16, *) {
            navigationItem.style = .navigator
        }
//        else {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithDefaultBackground()
//            
//            appearance.backgroundColor = .systemBlue
//            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//
//            UINavigationBar.appearance().standardAppearance = appearance
//            UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        }
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
        
        dataSource = makeDataSource()
        updateSnapshot()
    }
    
    //
    
    private static func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    private func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        snapshot.appendItems([Row.title, Row.date, Row.time, Row.notes], toSection: .view)
        
        dataSource.apply(snapshot)
    }
    
    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section // In view mode, all items are displayed in section 0. In editing mode, the title, date, and notes are separated into sections.
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }
}

@available(iOS 17.0, *)
#Preview {
    ReminderDetailViewController(reminder: Reminder.sampleData[0])
}
