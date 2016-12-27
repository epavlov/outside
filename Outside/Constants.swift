//
//  Constants.swift
//  Outside
//
//  Created by Eugene Pavlov on 12/22/16.
//  Copyright © 2016 Eugene Pavlov. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let BASE_URL_FORECAST = "http://api.openweathermap.org/data/2.5/forecast?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "a00bc1e62a16718e8bee85316ecee307"

let CURRENT_WEATHER_URL = "\(BASE_URL + LATITUDE + "42.337757" + LONGITUDE + "-83.042641" + APP_ID + API_KEY)"

let FORECAST_WEATHER_URL = "\(BASE_URL_FORECAST + LATITUDE + "42.337757" + LONGITUDE + "-83.042641" + APP_ID + API_KEY)"
