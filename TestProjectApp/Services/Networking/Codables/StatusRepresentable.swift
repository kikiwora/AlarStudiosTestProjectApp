//
//  Status.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

protocol StatusRepresentable {
    var status: String { get }  // TODO: This probably should be transformed to enum
}

extension StatusRepresentable {
    func isUnauthorized() -> Bool {
        return status.uppercased() != "OK"
    }

    func hasAnError() -> Bool {
        return status.uppercased() == "ERROR"
    }
}
