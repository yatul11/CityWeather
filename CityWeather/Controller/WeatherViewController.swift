//
//  ViewController.swift
//  CityWeather
//
//  Created by Ivan on 18.07.2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController {
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    var cityName: String?
    var descriptionInfo: String?
    var feels_like: Double?
    var pressure: Double?
    var humidity: Double?
    var wind_speed: Double?
    var cloudiness: Double?
    var sunrise: Int?
    var sunset: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchText.delegate = self
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func infoPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToInfo", sender: self)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToInfo" {
            let destinationVC = segue.destination as! InfoViewController
            if let desriptionInfoText = self.descriptionInfo {
                destinationVC.descriptionString = desriptionInfoText
                destinationVC.feels_likeString = feels_like
                destinationVC.pressureString = pressure
                destinationVC.cloudinessString = cloudiness
                destinationVC.wind_speedString = wind_speed
                destinationVC.humidityString = humidity
                destinationVC.sunsetString = sunset
                destinationVC.sunriseString = sunrise
                destinationVC.cityNameString = cityName
            }
        }
    }
    
}



//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchText.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type city name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchText.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchText.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString
            self.weatherImage.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.descriptionLabel.text = weather.descriptionMain
            
            self.descriptionInfo = weather.description
            self.feels_like = weather.tempFeelsLike
            self.pressure = weather.pressure
            self.humidity = weather.humidity
            self.wind_speed = weather.windSpeed
            self.cloudiness = weather.clouds
            self.sunrise = weather.sunriseTime
            self.sunset = weather.sunsetTime
            self.cityName = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
