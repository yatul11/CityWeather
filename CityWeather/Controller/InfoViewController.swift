//
//  InfoViewController.swift
//  CityWeather
//
//  Created by Ivan on 19.07.2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import UIKit
import CoreLocation

class InfoViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    @IBOutlet weak var sunsetTimeLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var cloudinnesLabel: UILabel!
    
    var cityNameString: String?
    var descriptionString: String?
    var feels_likeString: Double?
    var pressureString: Double?
    var humidityString: Double?
    var wind_speedString: Double?
    var cloudinessString: Double?
    var sunriseString: Int?
    var sunsetString: Int?
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameLabel.text = cityNameString!
        descriptionLabel.text = descriptionString
        feelsLikeLabel.text = "Feels like \(String(format: "%1.f", feels_likeString!))°C"
        pressureLabel.text = String(Int(pressureString!)) + " hPa"
        humidityLabel.text = String(Int(humidityString!)) + " %"
        windSpeedLabel.text = String(Int(wind_speedString!)) + " m/s"
        cloudinnesLabel.text = String(Int(cloudinessString!)) + " %"
        if ((sunriseString! % 3600) / 60 < 10) {
        sunriseTimeLabel.text = "\( (((sunriseString! + 10800) % 86400) / 3600) ):0\( (sunriseString! % 3600) / 60 )"
        } else {
            sunriseTimeLabel.text = "\( (((sunriseString! + 10800) % 86400) / 3600) ):\( (sunriseString! % 3600) / 60 )"
        }
        if ((sunsetString! % 3600) / 60 < 10) {
        sunsetTimeLabel.text = "\( (((sunsetString! + 10800) % 86400) / 3600) ):0\( (sunsetString! % 3600) / 60 )"
        } else {
             sunsetTimeLabel.text = "\( (((sunsetString! + 10800) % 86400) / 3600) ):\( (sunsetString! % 3600) / 60 )"
        }
        
    }

}

extension InfoViewController: CLLocationManagerDelegate {
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
