//
//  LabelView.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 09.10.2020.
//

import UIKit

class LabelView: UIView {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    func render(name: String? = nil, value: String? = nil, showBorder: Bool = false) {
        if let name = name {
            nameLabel.isHidden = false
            nameLabel.text = name
        } else {
            nameLabel.isHidden = true
        }

        if let value = value {
            valueLabel.isHidden = false
            valueLabel.text = value
        } else {
            valueLabel.isHidden = true
        }

        borderView.borderWidth = showBorder ? Constants.defaultBorderWith : 0
    }
}

extension LabelView: NibLoadable {}

extension LabelView {
    enum Constants {
        static let defaultBorderWith: CGFloat = 1
    }
}
