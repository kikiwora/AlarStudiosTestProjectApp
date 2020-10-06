//
//  NetworkServiceFactory.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

enum NetworkServiceFactory {

    static func makeProjectAppNetworkService(_ sessionManager: SessionManager) -> TestProjectAppNetworkServiceType {
        return TestProjectAppService(.init(listeners: makeListeners(), sessionManager: sessionManager))
    }

    private static func makeListeners() -> [NetworkListener] {
        let listener = GenericNetworkListener(handler: {
            NotificationCenterEvents.userActionUnauthorized()
        })
        return [listener]
    }
}
