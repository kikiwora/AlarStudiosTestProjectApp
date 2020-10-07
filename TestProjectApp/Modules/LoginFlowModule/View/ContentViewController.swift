//
//  ContentViewController.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import UIKit

class ContentViewController: UIViewController {

    lazy var presenter: ContentViewOutput! = {
        let presenter = LoginFlowPresenter()
        presenter.contentView = self
        return presenter
    }()

    @IBAction func unwindToContentView(segue: UIStoryboardSegue) { }

    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserAuthorization()
    }
}

// MARK: - User Authorization Flow

extension ContentViewController: ContentViewType {
    func authorizationFinished() {
        checkUserAuthorization()
    }

    func dataLoaded() {
        // TODO
    }

    func showLoginForm() {
        self.performSegue(withIdentifier: Constants.showLoginSegueIdentifier, sender: self)
    }
}

extension ContentViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showLoginSegueIdentifier {
            let loginView = segue.destination as? LoginViewController
            loginView?.presenter = presenter as? LoginViewOutput
            (presenter as! LoginFlowPresenter).loginView = loginView
        }
    }

    private func checkUserAuthorization() {
        guard presenter.isUserAuthorized() else {
            presenter.performLogin()
            return
        }

        presenter.performDataLoad(page: 1)
    }
}

// MARK: - Constants

extension ContentViewController {
    enum Constants {
        static let showLoginSegueIdentifier = "showLogin"
    }
}
