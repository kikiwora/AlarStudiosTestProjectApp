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

    var presenter: LoginViewOutput! {
        didSet {
            (presenter as! LoginFlowPresenter).loginView = self
        }
    }

    var loginFormView: LoginFormView!
    var loginCallback: LoginFormView.LoginCallback?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginCallback()
    }
}

// MARK: -

extension LoginViewController: LoginViewType {
    func loginFailed() {
        // TODO: - Notify user here
        print("Login failed")
    }

    func loginSucceded() {
        // TODO: - Notify user here
        print("Login Succeded")
    }

    func returnToParent() {
        self.performSegue(withIdentifier: Constants.returnToContentViewSegueIdentifier, sender: self)
    }
}

// MARK: - Authorization Flow Methods

private extension LoginViewController {

    func setupLoginCallback() {
        loginCallback = { [weak self] (formInput: LoginFormView.CredentialsTuple) in
            self?.attemptLogin(with: formInput)
        }
    }

    func attemptLogin(with formInput: LoginFormView.CredentialsTuple) {
        presenter.attemptLogin(with: formInput)
    }
}

// MARK: - Constants

extension LoginViewController {
    enum Constants {
        static let returnToContentViewSegueIdentifier = "returnToContentView"
    }
}