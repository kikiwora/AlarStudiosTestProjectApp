//
//  NotificationCenterEvents.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

extension Notification.Name {
    static let userActionUnauthorized = Notification.Name(rawValue: "UserActionUnauthorized")
}

enum NotificationCenterEvents {
    static func userActionUnauthorized() {
        EventLogger.log("User request unauthorized")
        NotificationCenter.default.post(.init(name: .userActionUnauthorized))
    }
}
