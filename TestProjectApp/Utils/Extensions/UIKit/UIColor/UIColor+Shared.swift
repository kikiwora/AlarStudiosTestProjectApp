//
//  UIColor+Shared.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import UIKit.UIColor

extension UIColor {
    enum SharedTheme {
        enum Login {
            static let textFieldUnderlineColor: UIColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

            static func loginButtonBackground(for state: UIControl.State = .normal) -> UIColor {
                let defaultStateColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                switch state {
                    case .normal:
                        return defaultStateColor
                    case .highlighted:
                        return #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
                    default:
                        return defaultStateColor
                }
            }

            static func loginButtonTitleColor(for state: UIControl.State = .normal) -> UIColor {
                let defaultStateColor: UIColor = .white
                switch state {
                    case .normal:
                        return defaultStateColor
                    case .highlighted:
                        return .black
                    default:
                        return defaultStateColor
                }
            }
        }
    }
}
