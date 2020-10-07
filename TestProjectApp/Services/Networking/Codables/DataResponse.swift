//
//  DataResponse.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

struct DataResponse: StatusRepresentable, Decodable {
    private(set) var status: RequestStatus
    
    let page: Int
    let data: [DataElement]
}

struct DataElement: Decodable {
    let id: String
    let name: String
    let country: String
    let lat: Double
    let lon: Double
}
