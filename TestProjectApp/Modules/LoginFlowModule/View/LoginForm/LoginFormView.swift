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
            usernameField.setupLoginAppearance()
        }
    }
    @IBOutlet weak var passwordField: UITextField! {
        didSet {
            passwordField.placeholder = L10n.Login.passwordPlaceholder
            passwordField.delegate = self
            passwordField.setupLoginAppearance()
        }
    }
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.setupLoginAppearance()
        }
    }

    var onLogin: LoginCallback?
    var onKeyboardDismiss: Block.Empty?
    
    @IBAction func loginAction(_ sender: Any) {
        onLogin?((username: usernameField.text ?? "", password: passwordField.text ?? ""))
    }

    func viewDidLayoutSubviews() {
        usernameField.updateLoginAppearance()
        passwordField.updateLoginAppearance()
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

// MARK: - Custom UIButton for Login inputs

private extension UIButton {
    func setupLoginAppearance() {
        _ = ViewStyler(self).rounded(cornerRadius: 5)

        self.setBackgroundColor(UIColor.SharedTheme.Login.loginButtonBackground(), for: .normal)
        self.setTitleColor(UIColor.SharedTheme.Login.loginButtonTitleColor(), for: .normal)
        self.setBackgroundColor(UIColor.SharedTheme.Login.loginButtonBackground(for: .highlighted), for: .highlighted)
        self.setTitleColor(UIColor.SharedTheme.Login.loginButtonTitleColor(for: .highlighted), for: .highlighted)

        self.addTarget(self, action: #selector(touchDownEvent), for: .touchDown)
        self.addTarget(self, action: #selector(touchUpEvent), for: [.touchUpInside, .touchUpOutside, .touchCancel])

        return
    }

    @objc func touchDownEvent(sender: UIButton!) {
        UIView.animate(withDuration: LoginFormView.Constants.Animations.fadeOutDuration, delay: 0, options: [.allowUserInteraction], animations: {
            sender.alpha = LoginFormView.Constants.Animations.Colors.fadeOutAlpha
        }, completion: nil)
    }

    @objc func touchUpEvent(sender: UIButton!) {
        UIView.animate(withDuration: LoginFormView.Constants.Animations.fadeOutDuration, delay: 0, options: [.allowUserInteraction], animations: {
            sender.alpha = LoginFormView.Constants.Animations.Colors.fadeInAlpha
        }, completion: nil)
    }
}

// MARK: - Custom UITextField for Login inputs

private extension UITextField {

    func setupLoginAppearance() {
        bottomLine = CALayer()
        bottomLine?.frame = createBottomLifeFrame(from: self.frame)
        bottomLine?.backgroundColor = UIColor.SharedTheme.Login.textFieldUnderlineColor.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
        return
    }

    func updateLoginAppearance() {
        self.layoutIfNeeded()
        bottomLine?.frame = createBottomLifeFrame(from: self.frame)
    }

    func createBottomLifeFrame(from frame: CGRect) -> CGRect {
        return CGRect(x: 0.0, y: frame.height - 1, width: frame.width, height: 1.0)
    }
}

private extension UITextField {

    struct AssociatedKeys {
        static var bottomLine: UInt8 = 0
    }

    var bottomLine: CALayer? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.bottomLine) as? CALayer else {
                return nil
            }
            return value
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.bottomLine, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

// MARK: - Constants

private extension LoginFormView {
    enum Constants {
        enum Animations {
            enum Colors {
                static let fadeInAlpha: CGFloat = 1
                static let fadeOutAlpha: CGFloat = 0.5
            }

            static let fadeInDuration: TimeInterval = 0.3
            static let fadeOutDuration: TimeInterval = 0.5
        }
    }
}
