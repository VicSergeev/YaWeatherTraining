//
//  MapViewController.swift
//  YaWeather
//
//  Created by Victor on 01.08.2024.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController {
    
    // MARK: - creating map
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Дом"
        view.addSubview(mapView)
        
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                strongSelf.addMapPin(with: location)
            }
        }
    } // viewDidLoad
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
}

extension MapViewController {
    func addMapPin(with location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        mapView.setRegion(
            MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.2,
                    longitudeDelta: 0.2
                )
            ),
            animated: true
        )
        mapView.addAnnotation(pin)
        
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            self?.title = locationName
        }
    }
}
