//
//  UIView+Custom.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import UIKit

// MARK: - Nib

extension UIView {

    static var identifier: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }

    static var isNibExists: Bool {
        guard let path = Bundle.main.path(forResource: self.identifier, ofType: "nib") else { return false }
        return FileManager.default.fileExists(atPath: path)
    }
}

// MARK: - Alpha

extension UIView {

    func applyDisabledAlpha() {
        alpha = 0.3
    }

    func removeDisabledAlpha() {
        alpha = 1.0
    }

    func pin(toEdgesOf view: UIView, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right)
        ])
    }

    func pinToSafeArea(_ containerView: UIView, insets: UIEdgeInsets = .zero) {
        let safeArea = containerView.safeAreaLayoutGuide
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: safeArea.topAnchor, constant: insets.top),
            leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: insets.left),
            bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -insets.bottom),
            rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -insets.right)
        ])
    }

    func pinToCenter(of view: UIView) {
        let safeArea = view.safeAreaLayoutGuide
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
    }

    func makeConstraints(_ block: ((UIView) -> [NSLayoutConstraint])) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(block(self))
    }
}
