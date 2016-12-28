//
//  WeatherCell.swift
//  Outside
//
//  Created by Eugene Pavlov on 12/27/16.
//  Copyright © 2016 Eugene Pavlov. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    /**
     Function to update table cell data
     
     - parameter forecast: ForecastWeather() class object
     */
    func configureCell(forecast: ForecastWeather) {
        lowTempLabel.text = "\(forecast.lowTemp)°"
        highTempLabel.text = "\(forecast.highTemp)°"
        dayLabel.text = forecast.date
        weatherTypeLabel.text = forecast.weatherType
        weatherIcon.image = UIImage(named: forecast.weatherType)
        
    }
}
