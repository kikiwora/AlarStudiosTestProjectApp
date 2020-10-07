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
        }
    }
    @IBOutlet weak var passwordField: UITextField! {
        didSet {
            passwordField.placeholder = L10n.Login.passwordPlaceholder
        }
    }

    var onLogin: LoginCallback?
    
    @IBAction func loginAction(_ sender: Any) {
        onLogin?((username: usernameField.text ?? "", password: passwordField.text ?? ""))
    }
}

extension LoginFormView: NibLoadable { }

// MARK: - LoginForm ViewModel

struct LoginFormViewModel {
    let loginState: LoginState = .unattempted
}

extension LoginFormViewModel {
    enum LoginState {
        case success
        case failure
        case unattempted
    }
}

extension LoginFormView {
    func render(_ viewModel: LoginFormViewModel = LoginFormViewModel()) {
        if viewModel.loginState == .failure {
            print("Login Failed")
        }
    }
}
