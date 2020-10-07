//
//  Result.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

typealias Result<Success> = Swift.Result<Success, Error>

extension Swift.Result {

    var value: Success? {
        return try? self.get()
    }

    var error: Error? {
        switch self {
            case .success:
                return nil
            case .failure(let error):
                return error
        }
    }
}

extension Swift.Result where Failure == Swift.Error {

    func tryMap<NewSuccess>(transform: (Success) throws -> NewSuccess) -> Swift.Result<NewSuccess, Failure> {
        return map { value in Result { try transform(value) } }
            .flatMap { $0 }
    }
}
