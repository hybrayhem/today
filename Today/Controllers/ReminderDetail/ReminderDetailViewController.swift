//
//  ReminderDetailViewController.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

class ReminderDetailViewController: UICollectionViewController {
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    var reminder: Reminder {
        didSet {
            onChange(reminder)
        }
    }
    var workingReminder: Reminder // temp reminder used in editing mode, saved or discarded after
    var isAddingNewReminder: Bool = false // indicate editing or creating a reminder
    var onChange: (Reminder) -> Void
    private var dataSource: DataSource!
    
    init(reminder: Reminder, onChange: @escaping (Reminder) -> Void) {
        self.reminder = reminder
        self.workingReminder = reminder
        self.onChange = onChange

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
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
        navigationItem.rightBarButtonItem = editButtonItem
        
        dataSource = makeDataSource()
        updateSnapshotForViewing()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            prepareForEditing()
        } else if isAddingNewReminder {
            prepareForAdding()
        } else {
            prepareForViewing()
        }
    }
    
    //
    
    private static func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        
        listConfiguration.showsSeparators = false
        listConfiguration.headerMode = .firstItemInSection
        
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    @objc func didCancelEdit() {
        workingReminder = reminder // reset workingReminder
        setEditing(false, animated: true)
    }
    
    private func prepareForAdding() {
        onChange(workingReminder) // Update page with this empty reminder
    }
    
    private func prepareForViewing() {
        navigationItem.leftBarButtonItem = nil
        
        if workingReminder != reminder {
            reminder = workingReminder
        }
        updateSnapshotForViewing()
    }
    
    private func prepareForEditing() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(didCancelEdit)
        )
        
        updateSnapshotForEditing()
    }
    
    private func updateSnapshotForViewing() {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.view])
        snapshot.appendItems([Row.header(""), Row.title, Row.date, Row.time, Row.notes], toSection: .view)
        
        dataSource.apply(snapshot)
    }
    
    private func updateSnapshotForEditing() {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.title, .date, .notes])
        
        snapshot.appendItems(
            [.header(Section.title.name), .editableText(reminder.title)],
            toSection: .title
        )

        snapshot.appendItems(
            [.header(Section.date.name), .editableDate(reminder.dueDate)],
            toSection: .date
        )
        
        snapshot.appendItems(
            [.header(Section.notes.name), .editableText(reminder.notes)],
            toSection: .notes
        )
        
        dataSource.apply(snapshot)
    }
}

@available(iOS 17.0, *)
#Preview {
    ReminderDetailViewController(reminder: Reminder.sampleData[0], onChange: { _ in })
}
