//
//  ListElementView.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 09.10.2020.
//

import UIKit

class ListElementView: UIView {

    func render(_ viewModel: ViewModel) {

    }
}

extension ListElementView: NibLoadable { }

// MARK: - ViewModel

extension ListElementView {
    struct ViewModel {
        let name: String?
        var image: UIImage?
    }
}

extension ListElementView.ViewModel {
    enum Factory {
        static func make(from dataElement: DataElement) -> ListElementView.ViewModel {
            return ListElementView.ViewModel(name: dataElement.name,
                                             image: nil)
        }
    }
}
