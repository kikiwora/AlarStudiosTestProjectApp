//
//  NetworkProvider.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation
import Network

typealias NetworkCompletionTuple = (data: Data?, response: URLResponse?, error: Error?)
typealias NetworkCompletionHandler = (NetworkCompletionTuple) -> Void

protocol NetworkProviderType {
    associatedtype Target: TargetType

    @discardableResult func sendRequest(_ endpoint: Endpoint, completion: @escaping(NetworkCompletionHandler)) -> URLSessionDataTask?
    func endpoint(_ target: Target) -> Endpoint
}

protocol NetworkListener {
    func didReceive(_ : NetworkCompletionTuple)
}

class NetworkProvider<Target: TargetType>: NetworkProviderType {
    let sessionManager: SessionManager
    private let listeners: [NetworkListener]

    init(listeners: [NetworkListener] = [], sessionManager: SessionManager) {
        self.listeners = listeners
        self.sessionManager = sessionManager
    }

    @discardableResult func sendRequest(_ endpoint: Endpoint, completion: @escaping(NetworkCompletionHandler)) -> URLSessionDataTask? {
        // Network request here

        let endpoint = sessionManager.prepareEndpoint(endpoint.addParamsToURL(endpoint.parameters))

        let request = NSMutableURLRequest(url: endpoint.url)
        request.timeoutInterval = Environment().timeoutInterval
        request.httpMethod = endpoint.httpMethod.rawValue
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { [listeners] data, response, error in
            let tuple = (data, response, error)
            listeners.didReceive(tuple)

            DispatchQueue.main.async {
                completion(tuple)
            }
        }

        task.resume()
        return task
    }

    func endpoint(_ target: Target) -> Endpoint {
        return Endpoint(url: target.url, httpMethod: target.method, headers: target.headers, parameters: target.parameters)
    }
}

private extension Array where Element == NetworkListener {

    func didReceive (_ tuple: NetworkCompletionTuple) {
        self.forEach({ $0.didReceive(tuple) })
    }
}

private extension SessionManager {
    func prepareEndpoint(_ endpoint: Endpoint) -> Endpoint {
        if let code = self.code, !code.isEmpty {
            return endpoint.addParamsToURL(["code": code])
        }

        return endpoint
    }
}
