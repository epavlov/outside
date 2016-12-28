//
//  LocationManager.swift
//  Outside
//
//  Created by Eugene Pavlov on 12/27/16.
//  Copyright © 2016 Eugene Pavlov. All rights reserved.
//

import Foundation
import CoreLocation

/// Location manager class to aquire user device location and load coordinates into another Location singleton class
class LocationManager: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override init() {
        super.init()
        
        // Set up location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // accuracy
        locationManager.requestWhenInUseAuthorization() // ask for tracking location when app in use
        locationManager.startMonitoringSignificantLocationChanges() // start tracking location
    }
    
    /**
     Function to ask user for using location
     
     - parameter completion: Bool, Optional completion handler
     
     - returns: Bool
     */
    func locationAuthStatus(completion: (_ result: Bool) -> Void = { _ in }) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            
            setCoordinates(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
            completion(true)
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    /**
     Function to set user device coordinates into Location singleton class
     
     - parameter latitude: CLLocationDegrees
     - parameter longitude: CLLocationDegrees
     */
    func setCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        Location.sharedInstance.latitude = latitude
        Location.sharedInstance.longitude = longitude
    }
}
