//
//  XIBLocalizable.swift
//  AlarStudiosTestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import UIKit

protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}

extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set { text = newValue?.localized }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set { setTitle(newValue?.localized, for: .normal) }
    }
}

extension UINavigationItem: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set { title = newValue?.localized }
    }
}

extension UIBarButtonItem: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set { title = newValue?.localized }
    }
}

private extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
