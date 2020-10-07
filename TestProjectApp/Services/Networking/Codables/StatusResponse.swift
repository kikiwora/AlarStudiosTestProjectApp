//
//  StatusResponse.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

struct StatusResponse: StatusRepresentable, Decodable {
    private(set) var status: RequestStatus
}
