//
//  DataListRepresentable.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 15.10.2020.
//

import Foundation

protocol DataListRepresentable: Hashable {
    associatedtype DataElementType
    var page: Int { get }
    var data: [DataElementType] { get }
}

extension DataListRepresentable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(page)
    }
}
