//
//  ElementDetailView.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 09.10.2020.
//

import UIKit

class ElementDetailView: UIView {
    
    @IBOutlet weak var elementDetailContentView: UIView! {
        didSet {
            // TODO: Customization here
        }
    }
    @IBOutlet weak var countryLabelContainer: UIView!
    @IBOutlet weak var nameLabelContainer: UIView!

    lazy var nameLabel: LabelView! = .instantiateFromNib(in: nameLabelContainer)
    lazy var countryLabel: LabelView! = .instantiateFromNib(in: countryLabelContainer)
    
    @IBOutlet weak var mapViewContainer: UIView!
    lazy var mapView: MapView = .instantiateFromNib(in: mapViewContainer)
    
    func render(_ viewModel: ViewModel) {
        let mapViewModel = MapView.ViewModel.Factory.make(from: viewModel)
        
        mapView.render(mapViewModel)
        nameLabel.render(name: L10n.ElementDetail.Label.name, value: viewModel.name)
        countryLabel.render(name: L10n.ElementDetail.Label.country, value: viewModel.country)
    }
}

extension ElementDetailView: NibLoadable { }

// MARK: - ViewModel

extension ElementDetailView {
    struct ViewModel {
        let name: String?
        let country: String?
        let lat: Double?
        let lon: Double?
    }
}

extension ElementDetailView.ViewModel {
    enum Factory {
        static func make(from dataElement: DataElement) -> ElementDetailView.ViewModel {
            return ElementDetailView.ViewModel(name: dataElement.name,
                                               country: dataElement.country,
                                               lat: dataElement.lat,
                                               lon: dataElement.lon)
        }
    }
}
