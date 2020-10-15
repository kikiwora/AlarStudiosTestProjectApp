//
//  ContentInteractor.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 15.10.2020.
//

import Foundation

class ContentInteractor {
    weak var presenter: ContentPresenterType!
}

extension ContentInteractor: ContentPresenterOutput {

}
