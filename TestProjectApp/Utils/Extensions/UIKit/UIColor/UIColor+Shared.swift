//
//  UIColor+Shared.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import UIKit.UIColor

extension UIColor {
    enum Shared {
        enum Backgroud {
            static let appIconBackgroundColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.5335745215, blue: 0.01497463789, alpha: 1)
            static let appIconBackgroundColorLight: UIColor = #colorLiteral(red: 0.1917871968, green: 0.6, blue: 0.01683885263, alpha: 1)
            static let genericWhiteBackgroundColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        enum Border {
            static let genericGreenBorderColor: UIColor = #colorLiteral(red: 0, green: 0.4484122992, blue: 0, alpha: 1)
        }
        enum Sheet {
            static let genericOffWHiteSheetColor: UIColor = #colorLiteral(red: 0.9607340693, green: 0.9608191848, blue: 0.9606630206, alpha: 1)
        }
        enum Text {
            static let genericWhiteTextColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}
