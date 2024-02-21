//
//  ReminderViewController.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

class ReminderViewController: UICollectionViewController {
    var reminder: Reminder

    init(reminder: Reminder) {
        self.reminder = reminder

        let listLayout = ReminderViewController.listLayout()
        super.init(collectionViewLayout: listLayout)
    }

    required init?(coder: NSCoder) {
        fatalError("Always initialize ReminderViewController using init(reminder:)")
    }
    
    private static func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    func text(for row: Row) -> String? {
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        }
    }
}
