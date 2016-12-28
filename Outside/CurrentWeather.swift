//
//  CurrentWeather.swift
//  Outside
//
//  Created by Eugene Pavlov on 12/22/16.
//  Copyright © 2016 Eugene Pavlov. All rights reserved.
//

import Foundation
import Alamofire

/// Loads and manages todays weather
class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil { _cityName = "" }
        return _cityName
    }
    var date: String {
        if _date == nil { _date = "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    var weatherType: String {
        if _weatherType == nil { _weatherType = "" }
        return _weatherType
    }
    var currentTemp: Double {
        if _currentTemp == nil { _currentTemp = 0.0 }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completion: @escaping () -> Void) {
        // Alamofire donwload
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in

            //print("Results:")
            //print(response.request!)  // original URL request
            //print(response.response!) // HTTP URL response
            //print(response.data!)     // server data
            //print(response.result)   // result of response serialization
            
            // Get JSON responce and cast it to Dictionary
            if let JSON = response.result.value as? Dictionary<String, AnyObject> {
                //print(JSON["name"]!)
                
                // Parce JSON responce
                if let name = JSON["name"] as? String {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                if let weather = JSON["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                }
                if let main = JSON["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemp = main["temp"] as? Double {
                        let kelvinToFarenheitPreDevision = (currentTemp * (9/5) - 459.67)
                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDevision/10))
                        self._currentTemp = kelvinToFarenheit
                    }
                }
                
            }
            // Call complition handler
            completion()
        }
    }
}
