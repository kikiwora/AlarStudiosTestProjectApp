//
//  Status.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

protocol StatusRepresentable {
    var status: RequestStatus { get }
}

extension StatusRepresentable {
    func isOK() -> Bool {
        return status == .ok
    }

    func isUnauthorized() -> Bool {
        return status == .noSession
    }

    func hasAnError() -> Bool {
        return status == .error
    }
}

enum RequestStatus: String, Decodable {
    case ok = "ok"
    case error = "error"
    case noSession = "no session"
}
