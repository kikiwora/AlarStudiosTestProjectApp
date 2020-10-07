//
//  GenericNetworkListener.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Network
import Foundation

final class UnauthorizedNetworkListener: NetworkListener {
    private let unauthorizedHandler: () -> Void

    init(handler: @escaping () -> Void) {
        self.unauthorizedHandler = handler
    }

    func didReceive(_ tuple: NetworkCompletionTuple) {
        guard let data = tuple.data else { return }

        switch data.decoded(StatusResponse.self) {
            case .success(let responseStatus):
                if responseStatus.isUnauthorized() {
                    unauthorizedHandler()
                }

            default: return
        }
    }
}
