//
//  Location.swift
//  Outside
//
//  Created by Eugene Pavlov on 12/27/16.
//  Copyright © 2016 Eugene Pavlov. All rights reserved.
//

import Foundation
import CoreLocation

/// Singleton class to store user device location coordinates
class Location {
    static var sharedInstance = Location()
    
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
