//
//  Environment.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

struct Environment {
    let baseURL: URL
    let timeoutInterval: TimeInterval

    init(info: [String: Any] = Bundle.main.infoDictionary ?? [:]) {
        do {
            let data = try JSONSerialization.data(withJSONObject: info)
            let components = try JSONDecoder().decode(Components.self, from: data)
            baseURL = try components.makeURL()
            timeoutInterval = try components.makeTimeoutInterval()
        } catch {
            fatalError("Configuration is missing from Info.plist or *.xcconfig")
        }
    }

    private struct Components: Decodable {
        let scheme: String
        let serverURL: String
        let timeoutInterval: String

        func makeURL() throws -> URL {
            guard let url = URL(string: scheme + "://" + serverURL) else {
                throw NSError(domain: "URL cannot be created", code: 0, userInfo: nil)
            }
            return url
        }

        func makeTimeoutInterval() throws -> TimeInterval {
            guard let timeoutInterval = TimeInterval(timeoutInterval) else {
                throw NSError(domain: "timeoutInterval cannot be created", code: 0, userInfo: nil)
            }
            return timeoutInterval
        }

        private enum CodingKeys: String, CodingKey {
            case scheme = "protocol"
            case serverURL = "server_url"
            case timeoutInterval = "timeout_interval"
        }
    }
}

extension Environment {

    enum EnvironmentType {
        case production
        case test
    }

    static var environmentType: EnvironmentType {
        return .production
    }

    static var isInProduction: Bool {
        return environmentType == .production
    }
}
