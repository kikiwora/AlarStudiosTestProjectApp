//
//  SessionManager.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

final class SessionManager {
    private static let codeKey = "code"

    private(set) var code: String?  // Needed to avoid frequent disk reads
    private var storedCode: String? {
        get {
            do {
                return try Storage.SharedStorage.get(SessionManager.codeKey) as? String
            } catch {
                return nil
            }
        }
        set {
            Storage.SharedStorage.save(SessionManager.codeKey, value: newValue as Any)
        }
    }

    init() {
        code = storedCode
    }

    func clearSession() {
        code = nil
        Storage.SharedStorage.delete(SessionManager.codeKey)
    }

    func saveSession(with code: String) {
        self.code = code
        storedCode = code
    }

    func isUserAuthorized() -> Bool {
        return (code != nil) && code?.isEmpty == false
    }
}

extension SessionManager {
    @objc func userActionUnauthorized() {
        clearSession()
    }

    func setupNotificationCentre() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userActionUnauthorized),
                                               name: .userActionUnauthorized,
                                               object: nil)
    }
}
