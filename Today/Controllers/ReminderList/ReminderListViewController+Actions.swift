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
        let viewController = ReminderDetailViewController(reminder: reminder)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = reminders[indexPath.item].id
        pushDetailViewForReminder(withId: id)
        return false
    }
}
