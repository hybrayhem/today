//
//  DatePickerContentView.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

class DatePickerContentView: UIView {
    let datePicker = UIDatePicker()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(datePicker)
        
        // Specific part
        datePicker.preferredDatePickerStyle = .inline
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        datePicker.date = configuration.date
    }
}

extension DatePickerContentView: UIContentView {
    struct Configuration: UIContentConfiguration {
        var date = Date.now
        
        func makeContentView() -> UIView & UIContentView {
            return DatePickerContentView(self)
        }
    }
}


extension UICollectionViewListCell {
    func datePickerConfiguration() -> DatePickerContentView.Configuration {
        DatePickerContentView.Configuration()
    }
}
