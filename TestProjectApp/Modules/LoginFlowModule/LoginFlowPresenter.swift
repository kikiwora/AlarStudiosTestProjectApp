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
    
    private func processLoginError(for response: LoginResponse) {
        if response.hasAnError() {
            onLoginFailed(PresentableError.loginDenied)
        } else {
            onLoginFailed(PresentableError.genericRetry)
        }
    }
    
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
    
    private func processDataLoadError(for response: DataResponse) {
        if response.isUnauthorized() { return }
        
        onDataLoadFailed(PresentableError.genericRetry)
    }
    
    private func onLoginFinished() {
        loginView.loginSucceded()
        loginView.returnToParent()
        contentView.authorizationFinished()
    }
    
    private func onLoginFailed(_ error: Error) {
        loginView.loginFailed(error)
    }
    
    private func onDataLoadFailed(_ error: Error) {
        contentView.dataLoadingFailed(error)
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
