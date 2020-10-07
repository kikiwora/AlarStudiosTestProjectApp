//
//  NibLoadable.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 07.10.2020.
//

import UIKit

protocol NibLoadable: class {}

extension NibLoadable where Self: UIView {

    typealias Configurator = (Self) -> Void

    static func instantiateFromNib(_ configurator: Configurator? = nil) -> Self {

        // swiftlint:disable force_cast
        let view = nib.instantiate(withOwner: nil, options: nil).first as! Self
        // swiftlint:enable force_cast
        configurator?(view)

        return view
    }

    static var nib: UINib {
        return UINib(nibName: "\(Self.self)", bundle: nil)
    }

    static func instantiateFromNib(in container: UIView,
                                   insets: UIEdgeInsets = .zero,
                                   configurator: Configurator? = nil) -> Self {
        let view = Self.instantiateFromNib(configurator)
        container.addSubview(view)
        view.pin(toEdgesOf: container, insets: insets)
        return view
    }
}
