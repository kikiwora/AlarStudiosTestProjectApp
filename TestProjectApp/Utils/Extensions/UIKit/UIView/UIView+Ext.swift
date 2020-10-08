//
//  UIView+Ext.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 08.10.2020.
//

import UIKit

extension UIView {
    func removeAllSublayers() {
        self.layer.sublayers?.removeAll()
    }
}
