//
//  Constants.swift
//  Outside
//
//  Created by Eugene Pavlov on 12/22/16.
//  Copyright © 2016 Eugene Pavlov. All rights reserved.
//

import Foundation

let BASE_URL_CURRENT = "http://api.openweathermap.org/data/2.5/weather?"
let BASE_URL_FORECAST = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let LATITUDE = "lat=\(Location.sharedInstance.latitude!)"
let LONGITUDE = "&lon=\(Location.sharedInstance.longitude!)"
let API_KEY = "&appid=a00bc1e62a16718e8bee85316ecee307&cnt=6"

let CURRENT_WEATHER_URL = "\(BASE_URL_CURRENT + LATITUDE + LONGITUDE + API_KEY)"

let FORECAST_WEATHER_URL = "\(BASE_URL_FORECAST + LATITUDE + LONGITUDE + API_KEY)"
