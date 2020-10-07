//
//  UIStoryboard+Ext.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import UIKit

protocol XIBAppearance {

    var cornerRadius: CGFloat { get set }

    var isCircularCorners: Bool { get set }

    var borderWidth: CGFloat { get set }
}

extension UIView: XIBAppearance {

    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            ViewStyler(self).rounded(cornerRadius: newValue).apply()
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set {
            ViewStyler(self).border(width: newValue, color: borderColor).apply()
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            ViewStyler(self).border(width: borderWidth, color: newValue).apply()
        }
    }

    @IBInspectable var isCircularCorners: Bool {
        get {
            let cornerRadius = CGFloat.minimum(frame.width, frame.height)
            return layer.cornerRadius == cornerRadius / 2.0
        }
        // swiftlint:disable:next unused_setter_value
        set {
            ViewStyler(self).circularCorners().apply()
        }
    }
}
