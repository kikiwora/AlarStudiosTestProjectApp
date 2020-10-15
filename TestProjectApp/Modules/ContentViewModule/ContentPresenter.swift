//
//  ContentPresenter.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 15.10.2020.
//

import Foundation

class ContentPresenter {
    lazy var interactor: ContentPresenterOutput! = {
        let interactor = ContentInteractor()
        interactor.presenter = self
        return interactor
    }()

    weak var elementsListView: ElementsListViewType!
}

extension ContentPresenter: ContentPresenterType { }

// MARK: - Data Load Methdos

extension ContentPresenter {

}
