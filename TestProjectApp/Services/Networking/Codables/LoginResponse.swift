//
//  LoginResponse.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

struct LoginResponse: StatusRepresentable, Decodable {
    private(set) var status: String
    
    let code: String
}
