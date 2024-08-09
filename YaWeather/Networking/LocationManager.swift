//
//  LocationManager.swift
//  YaWeather
//
//  Created by Victor on 01.08.2024.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let locationManager = CLLocationManager()
    var completion: ((CLLocation)-> Void)?
    
    public func getUserLocation(completion: @escaping ((CLLocation)-> Void)) {
        self.completion = completion
        locationManager.requestWhenInUseAuthorization() // user sees on the screem
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    public func resolveLocationName(
        with location: CLLocation,
        completion: @escaping ((String?) -> Void)
    ) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current) { placemarks, error in
            guard let place = placemarks?.first, error == nil else {
                completion(nil)
                return
            }
            
            print(place)
            
            var name = ""
            
            if let locality = place.locality {
                name += locality
            }
            
            if let street = place.name {
                name += ", \(street)"
            }
            
            completion(name)
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let currentLocation = locations.first else {
            return
        }
        completion?(currentLocation)
        locationManager.stopUpdatingLocation()
    }
}
