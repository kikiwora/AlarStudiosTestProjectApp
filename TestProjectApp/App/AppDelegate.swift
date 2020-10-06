//
//  AppDelegate.swift
//  AlarStudiosTestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var sessionManager: SessionManager!
    var networkingService: TestProjectAppNetworkServiceType!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        ApplicationSetup.initializeServices(for: self)
        testNetwork()

        return true
    }

    private func testNetwork() {
        networkingService?.login(username: "test", password: "123", completion: { [sessionManager, networkingService] response in
            print(response)

            if case .success(let loginResult) = response {
                if loginResult.isUnauthorized() { return }

                sessionManager?.code = loginResult.code

                networkingService?.fetchData(page: 1, completion: { result in
                    print(result)
                })
            }
        })
    }
}
