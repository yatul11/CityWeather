//
//  WeatherManager.swift
//  CityWeather
//
//  Created by Ivan on 19.07.2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    let api = "3dc5585578b32cf4d4656b06f779cf00"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&appid=\(api)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherUrl)&appid=\(api)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {

            let session = URLSession(configuration: .default)
        
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
    
        
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let tempFeelsLike = decodedData.main.feels_like
            let pressure = decodedData.main.pressure
            let humidity = decodedData.main.humidity
            let windSpeed = decodedData.wind.speed
            let clouds = decodedData.clouds.all
            let descriptionMain = decodedData.weather[0].main
            let description = decodedData.weather[0].description
            
            let sunriseTime = Int(decodedData.sys.sunrise)
            let sunsetTime = Int(decodedData.sys.sunset)
            
            let timestamp = NSDate().timeIntervalSince1970
            let myTime = Int(TimeInterval(timestamp))

            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, description: description, tempFeelsLike: tempFeelsLike, pressure: pressure, humidity: humidity, windSpeed: windSpeed, clouds: clouds, sunriseTime: sunriseTime, sunsetTime: sunsetTime, myTime: myTime, descriptionMain: descriptionMain)
            
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
}
