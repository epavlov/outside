//
//  WeatherVC.swift
//  Outside
//
//  Created by Eugene Pavlov on 12/20/16.
//  Copyright © 2016 Eugene Pavlov. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather = CurrentWeather()
    var forecastWeeather = ForecastWeather(weatherDict: [:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let locationManager = LocationManager()
        locationManager.locationAuthStatus { (true) in
            // Load weather data only when coordinates where acquired
            loadWeatherData()
        }
    }
    
    func loadWeatherData() {
        currentWeather.downloadWeatherDetails {
            // Will be called when data finished downloading
            self.updateCuurentWeatherUI()
        }
        
        forecastWeeather.donwloadForecastWeatherData {
            print(FORECAST_WEATHER_URL)
            // Remove today day from array
            self.forecastWeeather.forecasts.remove(at: 0)
            
            // Update UI after forecast data downloaded
            self.tableView.reloadData()
        }
    }
    
    func updateCuurentWeatherUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)°"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastWeeather.forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecastWeeather.forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
}

