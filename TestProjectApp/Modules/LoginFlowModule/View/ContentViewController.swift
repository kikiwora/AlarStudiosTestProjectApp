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

    weak var contentView: UIViewController?

    @IBAction func unwindToContentView(segue: UIStoryboardSegue) { }

    var dataReloadHandler: ((UIAlertAction) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        checkUserAuthorization()
    }

    private func loadContentView() {
        let contentView = Storyboard.ContentView.initialScene.instantiate()
        self.contentView = contentView
        self.addChild(contentView)
        presenter.performDataLoad(page: 1)
    }
}

// MARK: - User Authorization Flow

extension ContentViewController: ContentViewType {
    func authorizationFinished() {
        checkUserAuthorization()
    }

    func render(_ viewModel: ContentViewController.ViewModel) {
        // TODO
    }

    func dataLoadingFailed(_ error: Error) {
        if let presentableError = error as? PresentableError {
            let alertController = UIAlertController(title: presentableError.localizedTitle,
                                                    message: presentableError.localizedMessage,
                                                    preferredStyle: .alert)

            let defaultAction = UIAlertAction(title: "Try Again", style: .default, handler: dataReloadHandler)

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
            (presenter as! LoginFlowPresenter).loginView = loginView
        }
    }

    private func checkUserAuthorization() {
        guard presenter.isUserAuthorized() else {
            presenter.performLogin()
            return
        }

        loadContentView()
    }
}

// MARK: - Constants

extension ContentViewController {
    enum Constants {
        static let showLoginSegueIdentifier = "showLogin"
    }
}

// MARK: - ViewModel

extension ContentViewController {
    struct ViewModel {
        let page: Int?
        let content: [ContentElement]?
    }

    struct ContentElement {
        let name: String?
        let country: String?
        let lat: Double?
        let lon: Double?
    }
}

extension ContentViewController.ContentElement {
    enum Factory {
        static func make(from dataElement: DataElement) -> ContentViewController.ContentElement {
            return ContentViewController.ContentElement(name: dataElement.name,
                                                        country: dataElement.country,
                                                        lat: dataElement.lat,
                                                        lon: dataElement.lon)
        }
    }
}

extension ContentViewController.ViewModel {
    enum Factory {
        static func make(from dataResponse: DataResponse) -> ContentViewController.ViewModel {
            let contentElements = dataResponse.data?.map({ ContentViewController.ContentElement.Factory.make(from: $0) })
            return ContentViewController.ViewModel(page: dataResponse.page,
                                                   content: contentElements)
        }
    }
}
