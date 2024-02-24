//
//  UIAlertController+Error.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

extension UIAlertController {
    func showError(_ error: Error) {
        let alertTitle = NSLocalizedString("Error", comment: "Error alert title")
        let alert = UIAlertController(
            title: alertTitle,
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        let actionTitle = NSLocalizedString("OK", comment: "Alert OK button title")
        alert.addAction(
            UIAlertAction(
                title: actionTitle, style: .default,
                handler: { [weak self] _ in
                    self?.dismiss(animated: true)
                }
            )
        )
        
        present(alert, animated: true, completion: nil)
    }
}
