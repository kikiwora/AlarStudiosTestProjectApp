//
//  ContentViewController.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import UIKit

class ContentViewController: UIViewController {

    lazy var networkingService: TestProjectAppNetworkServiceType! = UIApplication.appDelegate?.networkingService

    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserAuthorization()
    }

    @IBAction func unwindToContentView(segue: UIStoryboardSegue) {
        checkUserAuthorization()
    }
}

// MARK: - User Authorization Flow

extension ContentViewController {

    func checkUserAuthorization() {
        if networkingService.sessionManager.isUserAuthorized() == false {
            performUserAuthorisation()
        } else {
            performDataLoad()
        }
    }

    func performUserAuthorisation() {
        self.performSegue(withIdentifier: Constants.showLoginSegueIdentifier, sender: self)
    }

    func performDataLoad() {
        networkingService.fetchData(page: 1, completion: { result in
            print(result)
        })
    }
}

// MARK: - Constants

extension ContentViewController {
    enum Constants {
        static let showLoginSegueIdentifier = "showLogin"
    }
}
