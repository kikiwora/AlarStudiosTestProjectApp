//
//  SessionManager.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

final class SessionManager {
    private var _code: String?

    var code: String? {
        get {
            return _code
        }
        set {
            _code = newValue
        }
    }

    func clearSession() {
        _code = nil
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
