//
//  TestProjectAppService.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Network

class TestProjectAppService: TestProjectAppNetworkServiceType {
    private let networkProvider: NetworkProvider<TestProjectAppTarget>
    
    init(_ networkProvider: NetworkProvider<TestProjectAppTarget>) {
        self.networkProvider = networkProvider
    }
}

// MARK: - ServiceType methods

protocol TestProjectAppNetworkServiceType {
    var sessionManager: SessionManager { get }

    func login(username: String, password: String, completion: @escaping (Result<LoginResponse>) -> Void)
    func fetchData(page: Int, completion: @escaping (Result<DataResponse>) -> Void)
}

extension TestProjectAppService {
    var sessionManager: SessionManager {
        return networkProvider.sessionManager
    }
}

extension TestProjectAppService {
    
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse>) -> Void) {
        let endpoint = networkProvider.endpoint(.login(["username": username,
                                                        "password": password]))
        
        networkProvider.sendRequest(endpoint) { tuple in
            if let responseStatus = tuple.data?.decoded(LoginResponse.self) {
                completion(responseStatus)
            } else {
                completion(.failure(PresentableError.incorrectResponse))
            }
        }
    }

    func fetchData(page: Int, completion: @escaping (Result<DataResponse>) -> Void) {
        let endpoint = networkProvider.endpoint(.data(["page": page]))
        
        networkProvider.sendRequest(endpoint) { tuple in
            if let responseStatus = tuple.data?.decoded(DataResponse.self) {
                completion(responseStatus)
            } else {
                completion(.failure(PresentableError.incorrectResponse))
            }
        }
    }
}
