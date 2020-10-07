//
//  ViewStyler.swift
//  Breweries
//
//  Created by Roman Suvorov on 15.07.2020.
//  Copyright © 2020 Roman Suvorov. All rights reserved.
//

import UIKit

struct ViewStyler {
    let view: UIView

    init(_ view: UIView) {
        self.view = view
    }

    func rounded(cornerRadius: CGFloat, corners: Corner = .all, shouldClip: Bool = true) -> ViewStyler {
        view.clipsToBounds = shouldClip
        view.layer.masksToBounds = shouldClip
        view.layer.cornerRadius = cornerRadius
        view.layer.maskedCorners = makeMaskedCorners(from: corners)
        return self
    }

    func circularCorners() -> ViewStyler {
        let cornerRadius = CGFloat.minimum(view.bounds.width,
                                           view.bounds.height) / 2
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = cornerRadius
        return self
    }

    func background(_ color: UIColor) -> ViewStyler {
        view.backgroundColor = color
        return self
    }

    func border(width: CGFloat, color: UIColor?) -> ViewStyler {
        view.layer.borderColor = color?.cgColor
        view.layer.borderWidth = width
        return self
    }

    func shadow(color: UIColor = .black,
                opacity: Float,
                radius: CGFloat = 0.0,
                background: UIColor = .clear,
                offset: CGSize = .zero) -> ViewStyler {
        view.layer.backgroundColor = background.cgColor
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOffset = offset
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = radius
        view.layer.masksToBounds = false
        return self
    }

    func apply() {
        // Nothing
    }

    func dashBorder(dashPattern: NSNumber, color: UIColor?, cornerRadius: CGFloat = 0) -> ViewStyler {
        let rect = CGRect(origin: view.bounds.origin, size: view.bounds.size)
        let layer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        layer.path = path.cgPath
        layer.strokeColor = color?.cgColor
        layer.lineDashPattern = [dashPattern, dashPattern]
        layer.backgroundColor = UIColor.clear.cgColor
        layer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(layer)
        return self
    }

    private func makeMaskedCorners(from corners: Corner) -> CACornerMask {
        var maskedCorners = CACornerMask()

        if corners.contains(.topLeft) { maskedCorners.insert(.layerMinXMinYCorner) }
        if corners.contains(.topRight) { maskedCorners.insert(.layerMaxXMinYCorner) }
        if corners.contains(.bottomLeft) { maskedCorners.insert(.layerMinXMaxYCorner) }
        if corners.contains(.bottomRight) { maskedCorners.insert(.layerMaxXMaxYCorner) }

        return maskedCorners
    }
}

extension ViewStyler {

    struct Corner: OptionSet {
        let rawValue: Int

        static let topLeft = Corner(rawValue: 1 << 0)
        static let topRight = Corner(rawValue: 1 << 1)
        static let bottomLeft = Corner(rawValue: 1 << 2)
        static let bottomRight = Corner(rawValue: 1 << 3)

        static let all: Corner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
        static let top: Corner = [.topLeft, .topRight]
        static let bottom: Corner = [.bottomLeft, .bottomRight]
    }
}
