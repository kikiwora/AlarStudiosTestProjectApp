//
//  TargetType.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

protocol TargetType {

    /// The target's base `URL`.
    var baseURL: URL { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    var method: HTTPMethod { get }

    /// The headers to be used in the request.
    var headers: HTTPHeaders? { get }

    /// The parameters to be used in the request.
    var parameters: [String: Any]? { get }
}

extension TargetType {

    var baseURL: URL {
        return Environment().baseURL
    }

    var url: URL {
        return path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
    }

    var headers: HTTPHeaders? {
        return nil
    }

    var parameters: [String: Any]? {
        return nil
    }
}
