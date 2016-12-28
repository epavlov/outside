//
//  TemperatureConverter.swift
//  Outside
//
//  Created by Eugene Pavlov on 12/27/16.
//  Copyright © 2016 Eugene Pavlov. All rights reserved.
//

import Foundation

class TemperatureConverter {
    
    /**
     Function to take Kelvin temperature and convert it to Fahrenheit
     
     - parameter kelvinValue: Double value in that indicates temperature in Kelvin
     
     - returns: Double value that will indicate temperature in Fahrenheit
     */
    public static func fromKelvinToFahrenheit(kelvinValue: Double) -> Double {
        let kelvinToFarenheitPreDevision = (kelvinValue * (9/5) - 459.67)
        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDevision/10))
        return kelvinToFarenheit
    }
}
