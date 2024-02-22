//
//  UIContentConfiguration+Stateless.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

extension UIContentConfiguration {
    
    // Provides a specialized configuration for a given state
    func updated(for state: UIConfigurationState) -> Self {
        return self // This project uses same configuration for all states
    }
    
}
