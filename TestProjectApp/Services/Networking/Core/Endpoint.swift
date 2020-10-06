//
//  Endpoint.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

typealias HTTPHeaders = [String: String]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct Endpoint {
    var url: URL
    var httpMethod: HTTPMethod
    var headers: HTTPHeaders?
    var parameters: [String: Any]?

    init(url: URL, httpMethod: HTTPMethod, headers: HTTPHeaders? = nil, parameters: [String: Any]? = nil) {
        self.url = url
        self.httpMethod = httpMethod
        self.headers = headers
        self.parameters = parameters
    }
}

extension Endpoint {
    func addParamsToURL(_ parameters: [String: Any]?) -> Endpoint {
        var endpoint = self

        if let params = parameters {
            // TODO: Note, the params are not guarded here, but they should be.
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = params.map { URLQueryItem(name: $0.key, value: ($0.value as? String) ?? "") }
            endpoint.url = components?.url ?? url
        }

        return endpoint
    }
}
