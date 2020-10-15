//
//  ElementsListViewController.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 08.10.2020.
//

import UIKit

class ElementsListViewController: UITableViewController {
    
    func render(_ viewModel: ViewModel) {

    }
}

// MARK: - ViewModel

extension ElementsListViewController {
    struct ViewModel {
        let page: Int?

        let elementViewModels: [ElementDetailView.ViewModel]?
    }
}

extension ElementsListViewController.ViewModel {
    enum Factory {
        static func make(from dataResponse: DataResponse) -> ElementsListViewController.ViewModel {
            let elementViewModels = dataResponse.data.map({ ElementDetailView.ViewModel.Factory.make(from: $0) })
            return ElementsListViewController.ViewModel(page: dataResponse.page,
                                                        elementViewModels: elementViewModels)
        }
    }
}
