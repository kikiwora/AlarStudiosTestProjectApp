//
//  MapView.swift
//  Breweries
//
//  Created by Roman Suvorov on 16.07.2020.
//  Copyright © 2020 Roman Suvorov. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView, NibLoadable {
    @IBOutlet weak var mapView: MKMapView!

    func render(_ viewModel: ViewModel) {
        guard  let cords = viewModel.coordinates else {
            mapView.isHidden = true
            return
        }

        mapView.isHidden = false
        mapView.centerToLocation(CLLocation(latitude: cords.latitude, longitude: cords.longitude))
    }
}

private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = Constants.regionRadius
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

// MARK: - ViewModel

extension MapView {
    struct ViewModel {
        typealias MapCoordinates = (latitude: Double, longitude: Double)

        let coordinates: MapCoordinates?
    }
}

extension MapView.ViewModel {
    enum Factory {
        static func make(from elementModel: ElementDetailView.ViewModel) -> MapView.ViewModel {
            guard let lon = elementModel.lon, let lat = elementModel.lat else {
                return MapView.ViewModel.init(coordinates: nil)
            }

            return MapView.ViewModel.init(coordinates: (latitude: lat, longitude: lon))
        }
    }
}

// MARK: - Constants

private extension MKMapView {
    enum Constants {
        static let regionRadius: CLLocationDistance = 1000
    }
}
