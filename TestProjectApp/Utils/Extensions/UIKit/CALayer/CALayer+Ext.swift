//
//  CALayer+Ext.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 08.10.2020.
//

import UIKit

extension CALayer {
    func addSublayer(_ layer: CALayer?) {
        guard let layer = layer else { return }
        self.addSublayer(layer)
    }
}
