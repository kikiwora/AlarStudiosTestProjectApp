//
//  LoginViewController.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import UIKit

class LoginViewController: UIViewController {

    var presenter: LoginViewOutput! {
        didSet {
            (presenter as? LoginFlowPresenter)?.loginView = self
        }
    }

    @IBOutlet weak var loginFormViewContainer: UIView! {
        didSet {
            loginFormView = LoginFormView.instantiateFromNib(in: loginFormViewContainer)
            loginFormView.onLogin = { [weak self] in self?.loginCallback?($0) }
        }
    }
    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var loginScrollViewBottomMargin: NSLayoutConstraint!

    var loginFormView: LoginFormView!
    var loginCallback: LoginFormView.LoginCallback?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginCallback()
        setupKeyboardDismiss()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginFormView.viewDidLayoutSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupKeyboardEvents()
    }

    override func viewDidDisappear(_ animated: Bool) {
        removeKeyboardEvents()
    }
}

// MARK: - Keyboard management methods

private extension LoginViewController {

    func setupKeyboardDismiss() {
        hideKeyboardWhenTappedAround()
        loginFormView.onKeyboardDismiss = { [weak self] in self?.dismissKeyboard() }
    }

    func setupKeyboardEvents() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    func removeKeyboardEvents() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func adjustInsetForKeyboardShow(_ show: Bool, notification: NSNotification) {
        guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        UIView.animate(withDuration: Constants.Animations.adjustInsetsForKeyboardDuration) { [weak self] in
            let adjustmentHeight = keyboardFrame.cgRectValue.height
            self?.loginScrollViewBottomMargin.constant = show ? adjustmentHeight : 0
            self?.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        adjustInsetForKeyboardShow(true, notification: notification)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        adjustInsetForKeyboardShow(false, notification: notification)
    }
}

// MARK: - Authorization Flow Methods

extension LoginViewController: LoginViewType {

    func loginSucceded() {
        loginFormView.render(LoginFormView.ViewModel.Factory.make(.success))
    }

    func loginFailed(_ error: Error) {
        loginFormView.render(LoginFormView.ViewModel.Factory.make(.failure(error: error)))
    }

    func returnToParent() {
        self.performSegue(withIdentifier: Constants.returnToContentViewSegueIdentifier, sender: self)
    }
}

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

        enum Animations {
            static let adjustInsetsForKeyboardDuration: TimeInterval = 0.3
        }
    }
}
