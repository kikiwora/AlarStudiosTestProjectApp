//
//  LoginFlowPresenter.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import Foundation

class LoginFlowPresenter: LoginFlowPresenterType {
    lazy var interactor: LoginFlowPresenterOutput! = {
        let interactor = LoginFlowInteractor()
        interactor.presenter = self
        return interactor
    }()
    
    weak var loginView: LoginViewType!
    weak var contentView: ContentViewType!
}

// MARK: - Session-related Methods

private extension LoginFlowPresenter {
    func setupSessionObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(sessionTokenFailed), name: .userActionUnauthorized, object: nil)
    }

    func removeSessionObserver() {
        NotificationCenter.default.removeObserver(self, name: .userActionUnauthorized, object: nil)
    }

    @objc func sessionTokenFailed() {
        performLogin()
    }
}

// MARK: - Login Methods

extension LoginFlowPresenter {
    func processLoginResponse(_ response: Result<LoginResponse>) {

        switch response {
        case .success(let response):
            guard response.isOK() else {
                processLoginError(for: response)
                return
            }

            interactor.saveUserSession(response.code)
            onLoginFinished()

        case .failure:
            onLoginFailed(PresentableError.incorrectResponse)
        }
    }

    private func onLoginFinished() {
        loginView.loginSucceded()
        loginView.returnToParent()
        performDataLoad(page: 1)
    }

    private func onLoginFailed(_ error: Error) {
        loginView.loginFailed(error)
    }

    private func processLoginError(for response: LoginResponse) {
        if response.hasAnError() {
            onLoginFailed(PresentableError.loginDenied)
        } else {
            onLoginFailed(PresentableError.genericRetry)
        }
    }
}

// MARK: - Data Load Methdos

extension LoginFlowPresenter {
    func dataLoaded(_ response: Result<DataResponse>) {
        switch response {
        case .success(let response):
            guard response.isOK() else {
                processDataLoadError(for: response)
                return
            }

            contentView.render(ElementsListViewController.ViewModel.Factory.make(from: response))
        case .failure(let error):
            contentView.dataLoadingFailed(error)
        }
    }

    private func onDataLoadFailed(_ error: Error) {
        contentView.dataLoadingFailed(error)
    }

    private func processDataLoadError(for response: DataResponse) {
        if response.isUnauthorized() { return }

        onDataLoadFailed(PresentableError.genericRetry)
    }

}

// MARK: - Methods for Login View

extension LoginFlowPresenter: LoginViewOutput {
    func attemptLogin(with formInput: LoginFormView.CredentialsTuple) {
        interactor.login(username: formInput.username, password: formInput.password)
    }
}

// MARK: - Methods for Content View

extension LoginFlowPresenter: ContentViewOutput {
    func viewDidAppear() {
        setupSessionObserver()
    }
    
    func viewDidDisappear() {
        removeSessionObserver()
    }

    func isUserAuthorized() -> Bool {
        return interactor.isUserAuthorized()
    }

    func checkUserAuthorization() {
        guard isUserAuthorized() else {
            performLogin()
            return
        }

        performDataLoad(page: 1)
    }

    func performLogin() {
        contentView.showLoginForm()
    }

    func performDataLoad(page: Int) {
        interactor.loadData(page: page)
    }
}
