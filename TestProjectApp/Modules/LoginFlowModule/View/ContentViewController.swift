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

    lazy var contentSplitViewController: UISplitViewController = {
        let contentView = Storyboard.ContentView.initialScene.instantiate() as UISplitViewController
        self.view.addSubview(contentView.view)
        contentView.view.pinToSafeArea(self.view)
        contentView.delegate = self
        return contentView
    }()

    @IBAction func unwindToContentView(segue: UIStoryboardSegue) { }

    var dataReloadHandler: ((UIAlertAction) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        contentSplitViewController.awakeFromNib()
        // TODO: Setup connection to ElementsListViewController here
    }

    override func viewDidAppear(_ animated: Bool) {
        presenter.checkUserAuthorization()
    }
}

// MARK: - Split View Controller Delegate

extension ContentViewController: UISplitViewControllerDelegate {

}

// MARK: - User Authorization Flow

extension ContentViewController: ContentViewType {

    func render(_ viewModel: ElementsListViewController.ViewModel) {

    }

    func dataLoadingFailed(_ error: Error) {
        if let presentableError = error as? PresentableError {
            let alertController = UIAlertController(title: presentableError.localizedTitle,
                                                    message: presentableError.localizedMessage,
                                                    preferredStyle: .alert)

            let defaultAction = UIAlertAction(title: L10n.Error.genericRetryMessage, style: .default, handler: dataReloadHandler)

            alertController.addAction(defaultAction)
            UIApplication.appDelegate?.window?.present(alertController)
        }
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
            (presenter as? LoginFlowPresenter)?.loginView = loginView
        }
    }
}

// MARK: - Constants

extension ContentViewController {
    enum Constants {
        static let showLoginSegueIdentifier = "showLogin"
    }
}
