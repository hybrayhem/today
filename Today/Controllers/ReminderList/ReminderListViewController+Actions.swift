//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
    
    private func completeReminder(withId id: Reminder.ID) {
        reminders.complete(id: id)
        updateSnapshot()
    }
}
