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

    // TODO: Note - I made use of UserDefaults to save some time, but in reality we should not use it due to security issues

    func save(_ key: String, value: Any) {
        UserDefaults.standard.setValue(value, forKey: key)
    }

    func get(_ key: String) throws -> Any? {
        return UserDefaults.standard.object(forKey: key) as Any
    }

    func delete(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
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
