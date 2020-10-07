//
//  LoginViewController.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginFormViewContainer: UIView! {
        didSet {
            loginFormView = LoginFormView.instantiateFromNib(in: loginFormViewContainer)
            loginFormView.onLogin = { [weak self] in self?.loginCallback?($0) }
        }
    }
    var loginFormView: LoginFormView!
    var loginCallback: LoginFormView.LoginCallback?

    lazy var networkingService: TestProjectAppNetworkServiceType! = UIApplication.appDelegate?.networkingService

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginCallback()
    }
}

extension LoginViewController {

    func setupLoginCallback() {
        loginCallback = { [weak self] (formInput: LoginFormView.CredentialsTuple) in
            self?.attemptLogin(with: formInput)
        }
    }

    func onLoginFinished() {
        self.performSegue(withIdentifier: Constants.returnToContentViewSegueIdentifier, sender: self)
    }
}

extension LoginViewController {
    enum Constants {
        static let returnToContentViewSegueIdentifier = "returnToContentView"
    }
}

// MARK: - Networking

extension LoginViewController {
    func attemptLogin(with formInput: LoginFormView.CredentialsTuple) {
        if networkingService.sessionManager.isUserAuthorized() {
            networkingService.sessionManager.clearSession()
        }

        networkingService.login(username: formInput.username,
                                password: formInput.password,
                                completion: { [weak self] result in
                                    self?.processLoginResults(result)
                                })
    }

    func processLoginResults(_ response: Result<LoginResponse>) {
        print(response)
        if case .success(let loginResult) = response {
            if !loginResult.isOK() {
                networkingService.sessionManager.clearSession()
                return
            }

            networkingService.sessionManager.saveSession(with: loginResult.code)

            onLoginFinished()
        }
    }
}
