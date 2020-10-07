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

        return true
    }
}
