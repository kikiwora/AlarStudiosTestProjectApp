//
//  Result.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}
