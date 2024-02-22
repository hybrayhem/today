//
//  TextFieldContentView.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

class TextFieldContentView: UIView {
    let textField = UITextField()


    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }


    init() {
        super.init(frame: .zero)
        addPinnedSubview(textField, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        textField.clearButtonMode = .whileEditing
    }


    required init?(coder: NSCoder) {
        fatalError("TextFieldContentView, init(coder:) has not been implemented")
    }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    TextFieldContentView()
}
