//
//  Data+Decoded.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

extension Data {
    
    func decoded<T: Decodable>(_ type: T.Type = T.self) -> Result<T> {
        do {
            let value = try JSONDecoder().decode(type, from: self)
            return .success(value)
        } catch {
            return .failure(error)
        }
    }
}
