//
//  TestProjectAppTarget.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

enum TestProjectAppTarget {
    case login(_ parameters: [String: Any])
    case data(_ parameters: [String: Any])
}

extension TestProjectAppTarget: TargetType {
    var path: String {
        switch self {
        case .login:
            return "test/auth.cgi"
        case .data:
            return "test/data.cgi"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login,
             .data:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .login (let parameters),
             .data(let parameters):
            return parameters
        }
    }
}
