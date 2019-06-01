//
//  AppLocationManager.swift
//  WeatherReportViper
//
//  Created by Iragam Reddy, Sreekanth Reddy on 6/1/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import MapKit

protocol AppLocationManagerDelegate {
    func updateLocation(location: CLLocationCoordinate2D?)
}

final class AppLocationManager: NSObject {
    static let shared = AppLocationManager()
    var delegate: AppLocationManagerDelegate?
    private var locationManager: CLLocationManager!
    private override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}

extension AppLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         locationManager.stopUpdatingLocation()
        let locValue:CLLocationCoordinate2D? = manager.location?.coordinate
        print("locations = \(locValue!.latitude) \(locValue!.longitude)")
        self.delegate?.updateLocation(location: locValue)
        
    }
}
