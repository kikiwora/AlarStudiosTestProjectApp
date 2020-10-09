//
//  ElementDetailView.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 09.10.2020.
//

import UIKit

class ElementDetailView: UIView {

    func render(_ viewModel: ViewModel) {

    }
}

extension ElementDetailView: NibLoadable { }

// MARK: - ViewModel

extension ElementDetailView {
    struct ViewModel {
        let name: String?
        let country: String?
        let lat: Double?
        let lon: Double?
    }
}

extension ElementDetailView.ViewModel {
    enum Factory {
        static func make(from dataElement: DataElement) -> ElementDetailView.ViewModel {
            return ElementDetailView.ViewModel(name: dataElement.name,
                                                        country: dataElement.country,
                                                        lat: dataElement.lat,
                                                        lon: dataElement.lon)
        }
    }
}
