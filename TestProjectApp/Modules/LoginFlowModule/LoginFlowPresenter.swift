//
//  LoginFlowPresenter.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import Foundation

class LoginFlowPresenter {
    lazy var interactor: LoginFlowPresenterOutput! = {
        let interactor = LoginFlowInteractor()
        interactor.presenter = self
        return interactor
    }()

    weak var loginView: LoginViewType!
    weak var contentView: ContentViewType!
}

extension LoginFlowPresenter: LoginFlowPresenterType {
    func processLoginResponse(_ response: Result<LoginResponse>) {
        if case .success(let loginResult) = response {
            if !loginResult.isOK() {
                interactor.clearUserSession()
                return
            }

            interactor.saveUserSession(loginResult.code)

            onLoginFinished()
        }
    }

    func dataLoaded(_ response: Result<DataResponse>) {
        contentView.dataLoaded()
    }

    private func onLoginFinished() {
        loginView.loginSucceded()
        loginView.returnToParent()
        contentView.authorizationFinished()
    }
}

extension LoginFlowPresenter: LoginViewOutput {
    func attemptLogin(with formInput: LoginFormView.CredentialsTuple) {
        interactor.login(username: formInput.username, password: formInput.password)
    }
}

extension LoginFlowPresenter: ContentViewOutput {
    func performLogin() {
        contentView.showLoginForm()
    }

    func performDataLoad(page: Int) {
        interactor.loadData(page: page)
    }

    func isUserAuthorized() -> Bool {
        return interactor.isUserAuthorized()
    }
}
