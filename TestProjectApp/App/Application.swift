//
//  Application.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import UIKit

enum Application {
    enum shared {
        static var appDelegate: AppDelegate? {
            return UIApplication.shared.delegate as? AppDelegate
        }
    }
}
