//
//  ReminderDetailViewController+Section.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

extension ReminderDetailViewController {
    enum Section: Int, Hashable { // data source uses hash values to determine changes in data
        case view
        case title
        case date
        case notes

        var name: String {
            switch self {
            case .view: return ""
            case .title:
                return NSLocalizedString("Title", comment: "Title section name")
            case .date:
                return NSLocalizedString("Date", comment: "Date section name")
            case .notes:
                return NSLocalizedString("Notes", comment: "Notes section name")
            }
        }
    }
}
