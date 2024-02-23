//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

extension ReminderListViewController {
    // Done button
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
    
    // Reminder Detail
    private func pushDetailViewForReminder(withId id: Reminder.ID) {
        let reminder = reminders.get(fromId: id)
        let viewController = ReminderDetailViewController(reminder: reminder) { [weak self] reminder in
            // onChange of Reminder:
            self?.reminders.update(reminder)
            self?.updateSnapshot(reloading: [reminder.id])
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = filteredReminders[indexPath.item].id
        pushDetailViewForReminder(withId: id)
        return false
    }
    
    // Add Reminder
    @objc func didPressAddButton(_ sender: UIBarButtonItem) {
        let reminder = Reminder(title: "", dueDate: Date.now)
        
        // Create View
        let viewController = ReminderDetailViewController(reminder: reminder) { [weak self]reminder in
            self?.reminders.add(reminder)
            self?.updateSnapshot()
            self?.dismiss(animated: true)
        }
        viewController.isAddingNewReminder = true
        viewController.setEditing(true, animated: false)
        
        // Navigation Buttons
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(didCancelAdd(_:))
        )
        viewController.navigationItem.title = NSLocalizedString("Add Reminder", comment: "Add Reminder view controller title")
        
        // Present View
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }
    
    
    @objc func didCancelAdd(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    // Segmented Control
    @objc func didChangeListStyle(_ sender: UISegmentedControl) {
        listStyle = ReminderListStyle(rawValue: sender.selectedSegmentIndex) ?? .today
        updateSnapshot()
        updateBackgroundColor()
    }
}
