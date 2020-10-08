//
//  LoginFormView.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import UIKit

extension LoginFormView {
    typealias CredentialsTuple = (username: String, password: String)
    typealias LoginCallback = ((CredentialsTuple) -> Void)
}

class LoginFormView: UIView {

    @IBOutlet weak var usernameField: UITextField! {
        didSet {
            usernameField.placeholder = L10n.Login.usernamePlaceholder
            usernameField.delegate = self
        }
    }
    @IBOutlet weak var passwordField: UITextField! {
        didSet {
            passwordField.placeholder = L10n.Login.passwordPlaceholder
            passwordField.delegate = self
        }
    }

    var onLogin: LoginCallback?
    var onKeyboardDismiss: Block.Empty?
    
    @IBAction func loginAction(_ sender: Any) {
        onLogin?((username: usernameField.text ?? "", password: passwordField.text ?? ""))
    }
}

extension LoginFormView: NibLoadable { }

extension LoginFormView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        let nextTag = textField.tag + 1

        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            onKeyboardDismiss?()
            loginAction(self)
        }

        return false
    }
}

// MARK: - LoginForm ViewModel

extension LoginFormView {
    struct ViewModel {
        let loginState: LoginState
    }
}

extension LoginFormView.ViewModel {
    enum LoginState {
        case success
        case failure
        case unattempted
    }
}

extension LoginFormView {
    func render(_ viewModel: ViewModel) {
        if viewModel.loginState == .failure {
            // TODO
        }
    }
}

extension LoginFormView.ViewModel {
    enum Factory {
        static func make(_ state: LoginState = .unattempted) -> LoginFormView.ViewModel {
            return .init(loginState: state)
        }
    }
}
