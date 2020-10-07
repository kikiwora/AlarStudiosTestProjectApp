//
//  UIWindow+Ext.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import UIKit

extension UIWindow {

    static func present(_ viewController: UIViewController, level: UIWindow.Level) {
        let window = UIWindow.window(with: level)
        window.present(viewController)
    }

    func present(_ viewController: UIViewController) {
        makeKeyAndVisible()
        rootViewController?.present(viewController, animated: true)
    }

    static func window(with level: UIWindow.Level) -> UIWindow {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = level
        return alertWindow
    }
}
