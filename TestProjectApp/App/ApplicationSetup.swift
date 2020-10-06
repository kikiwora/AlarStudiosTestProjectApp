//
//  ApplicationSetup.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

enum ApplicationSetup {

    static func initializeServices(for appDelegate: AppDelegate) {
        appDelegate.sessionManager = SessionManager()
        appDelegate.networkingService = NetworkServiceFactory.makeProjectAppNetworkService(appDelegate.sessionManager)

        appDelegate.sessionManager.setupNotificationCentre()
    }
}
