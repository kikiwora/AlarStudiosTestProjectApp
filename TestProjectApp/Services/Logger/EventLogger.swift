//
//  EventLogger.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation
import os.log

enum EventLogger<T> {
    static func log(_ data: T) {
        #if DEBUG
            print(data)
        #else
            os_log(data)
        #endif
    }
}
