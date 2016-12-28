//
//  ForecastWeather.swift
//  Outside
//
//  Created by Eugene Pavlov on 12/26/16.
//  Copyright © 2016 Eugene Pavlov. All rights reserved.
//

import UIKit
import Alamofire

/// Loads and manages forecast weather
class ForecastWeather {
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: Double!
    private var _lowTemp: Double!
    
    private var _forecasts: [ForecastWeather]!
    
    var date: String {
        get {
            return _date
        }
        set {
            _date = newValue
        }
    }
    
    var weatherType: String {
        get {
            return _weatherType
        }
        set {
            _weatherType = newValue
        }
    }
    
    var highTemp: Double {
        get {
            return _highTemp
        }
        set {
            _highTemp = newValue
        }
    }
    
    var lowTemp: Double {
        get {
            return _lowTemp
        }
        set {
            _lowTemp = newValue
        }
    }
    
    var forecasts: [ForecastWeather] {
        get {
            return _forecasts
        }
        set {
            _forecasts = newValue
        }
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        self.forecasts = []
        self.date = ""
        self.weatherType = ""
        self.lowTemp = 0.0
        self.highTemp = 0.0
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let min = temp["min"] as? Double {
                
                self._lowTemp = TemperatureConverter.fromKelvinToFahrenheit(kelvinValue: min)
            }
            
            if let max = temp["max"] as? Double {
                self._highTemp = TemperatureConverter.fromKelvinToFahrenheit(kelvinValue: max)
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
                print("Type: \(main)")
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
    
    func donwloadForecastWeatherData(completion: @escaping () -> Void) {
        // Alamofire donwload
        Alamofire.request(FORECAST_WEATHER_URL).responseJSON { response in
            
            //print("Results:")
            //print(response.request!)  // original URL request
            //print(response.response!) // HTTP URL response
            //print(response.data!)     // server data
            //print(response.result)   // result of response serialization
            
            // Get JSON responce and cast it to Dictionary
            if let JSON = response.result.value as? Dictionary<String, AnyObject> {
                //print(JSON["name"]!)
                
                // Parce JSON responce
                if let list = JSON["list"] as? [Dictionary<String, AnyObject>] {
                    //print("list:")
                    //print(list)
                    for obj in list {
                        //print(obj)
                        let forecast = ForecastWeather(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                }
                
            }
            // Call complition handler
            completion()
        }
    }
}

extension Date {
    /**
     Function to get day of the week from date
     - returns: full day of the week as String
     */
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // code to get full name of the week
        
        return dateFormatter.string(from: self)
    }
}
