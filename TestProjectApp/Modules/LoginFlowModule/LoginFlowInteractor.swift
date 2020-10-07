//
//  LoginFlowInteractor.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import UIKit.UIApplication

class LoginFlowInteractor {
    weak var presenter: LoginFlowPresenterType!

    private lazy var networkingService: TestProjectAppNetworkServiceType! = UIApplication.appDelegate?.networkingService
}

extension LoginFlowInteractor: LoginFlowPresenterOutput {
    func saveUserSession(_ code: String) {
        networkingService.sessionManager.saveSession(with: code)
    }

    func clearUserSession() {
        networkingService.sessionManager.clearSession()
    }

    func login(username: String, password: String) {
        if networkingService.sessionManager.isUserAuthorized() {    // It is wise to clear session if we attemt a new login
            networkingService.sessionManager.clearSession()
        }

        networkingService.login(username: username, password: password, completion: { [presenter] response in
            presenter?.processLoginResponse(response)
        })
    }

    func loadData(page: Int) {
        networkingService.fetchData(page: 1, completion: { [presenter] response in
            presenter?.dataLoaded(response)
        })
    }

    func isUserAuthorized() -> Bool {
        return networkingService.sessionManager.isUserAuthorized()
    }
}
