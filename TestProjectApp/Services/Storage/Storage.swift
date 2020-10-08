//
//  Storage.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 08.10.2020.
//

import Foundation

protocol StorageType {
    func save(_ key: String, value: Any)
    func get(_ key: String) throws -> Any?
    func delete(_ key: String)
}

struct PersistantStorage: StorageType {

    func save(_ key: String, value: Any) {

    }

    func get(_ key: String) throws -> Any? {
        return nil
    }

    func delete(_ key: String) {
        
    }
}

enum Storage {
    struct SharedStorage {
        static private let storage = PersistantStorage()

        static func save(_ key: String, value: Any) {
            storage.save(key, value: value)
        }

        static func get(_ key: String) throws -> Any? {
            return try storage.get(key)
        }

        static func delete(_ key: String) {
            storage.delete(key)
        }
    }
}
