//
//  EventLogger.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation
import os.log

enum EventLogger<T> where T: LosslessStringConvertible {
    static func log(_ data: T) {
        #if DEBUG
            print(data)
        #else
        if #available(iOS 14.0, *) {
            os_log("\(data)")
        } else {
            // TODO: Impelemnt logs support for iOS 12 here
        }
        #endif
    }
}
