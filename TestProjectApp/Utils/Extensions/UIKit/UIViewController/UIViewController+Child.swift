//
//  UIViewController+Child.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import UIKit

protocol ChildControllerSupportable: class {

    var containerView: UIView { get }
}

extension ChildControllerSupportable where Self: UIViewController {

    func updateContainer(with child: UIViewController) {
        updateContainer(with: child, animated: false)
    }

    func updateContainer(with child: UIViewController, animated: Bool) {
        removeAllChildren()
        addChild(child, animated)
    }

    private func addChild(_ child: UIViewController, _ animated: Bool) {
        addChild(child)
        updateView(with: child.view, animated)
        child.didMove(toParent: self)
    }

    private func updateView(with childView: UIView, _ animated: Bool) {
        var frame = containerView.frame
        frame.origin = .zero
        childView.frame = frame

        if animated {
            UIView.transition(with: containerView, duration: 0.25, options: .transitionCrossDissolve, animations: {
                self.containerView.addSubview(childView)
            }, completion: nil)
        } else {
            containerView.addSubview(childView)
        }
    }
}

extension UIViewController {

    func removeChild(_ child: UIViewController) {
        guard child.parent != nil else {
            return
        }

        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }

    func removeAllChildren() {
        children.forEach { removeChild($0) }
    }

    func add(child: UIViewController, container: UIView, configure: (_ childView: UIView) -> Void = { _ in }) {
        addChild(child)
        container.addSubview(child.view)
        configure(child.view)
        child.didMove(toParent: self)
    }
}
