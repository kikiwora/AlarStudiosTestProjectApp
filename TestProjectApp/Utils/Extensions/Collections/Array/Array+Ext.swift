//
//  Array+Ext.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import UIKit

extension Array {
    mutating func prepend(_ item: Element) {
        self.insert(item, at: 0)
    }
}

extension Array where Element: Equatable {

    mutating func remove(_ item: Element) {
        if let index = firstIndex(where: { $0 == item }) {
            remove(at: index)
        }
    }
}

extension Array {

    func with(_ element: Element?) -> [Element] {
        if let element = element {
            return self + [element]
        }
        return self
    }
}

extension Array where Element: UIView {
    func removeFromSuperview() {
        self.forEach { $0.removeFromSuperview() }
    }
}
