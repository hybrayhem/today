//
//  ReminderDetailViewController.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

class ReminderDetailViewController: UICollectionViewController {
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Row>
    
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
        snapshot.appendSections([0])
        snapshot.appendItems([Row.title, Row.date, Row.time, Row.notes], toSection: 0)
        dataSource.apply(snapshot)
    }
}

@available(iOS 17.0, *)
#Preview {
    ReminderDetailViewController(reminder: Reminder.sampleData[0])
}
