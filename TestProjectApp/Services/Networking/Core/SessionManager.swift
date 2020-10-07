//
//  SessionManager.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

final class SessionManager {
    private var _code: String?  // This should be in persistant storage

    var code: String? {
        get {
            return _code
        }
    }

    func clearSession() {
        _code = nil
    }

    func saveSession(with code: String) {
        _code = code
    }

    func isUserAuthorized() -> Bool {
        return (_code != nil) && _code?.isEmpty == false
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
