//
//  LoginFlowIO.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import Foundation

// MARK: - View IO

protocol LoginViewType: ViewType {
    func loginFailed(_ error: Error)
    func loginSucceded()
    func returnToParent()
}

protocol ContentViewType: ViewType {
    func authorizationFinished()
    func render(_ viewModel: ElementsListViewController.ViewModel)
    func dataLoadingFailed(_ error: Error)
    func showLoginForm()
}

protocol LoginViewOutput: class {
    func attemptLogin(with formInput: LoginFormView.CredentialsTuple) 
}

protocol ContentViewOutput: class {
    func performLogin()
    func performDataLoad(page: Int)
    func isUserAuthorized() -> Bool
}

// MARK: - Presenter IO

protocol LoginFlowPresenterType: class {
    func processLoginResponse(_ response: Result<LoginResponse>)
    func dataLoaded(_ response: Result<DataResponse>)
}

protocol LoginFlowPresenterOutput: class {
    func login(username: String, password: String)
    func loadData(page: Int)
    func isUserAuthorized() -> Bool
    func saveUserSession(_ code: String)
    func clearUserSession()
}
