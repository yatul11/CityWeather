//
//  WeatherModel.swift
//  CityWeather
//
//  Created by Ivan on 19.07.2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let description: String
    let tempFeelsLike: Double
    let pressure: Double
    let humidity: Double
    let windSpeed: Double
    let clouds: Double
    let sunriseTime: Int
    let sunsetTime: Int
    let myTime: Int
    let descriptionMain: String
    
    var tempString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        if (myTime < sunsetTime) && (myTime > sunriseTime) {
            switch conditionId {
            case 200...232:
                return "cloud.bolt.rain"
            case 300...321:
                return "cloud.drizzle"
            case 500...504:
                return "cloud.sun.rain"
            case 511...531:
                return "coud.heavyrain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...802:
                return "cloud.sun"
            default:
                return "cloud"
            }
        } else {
            switch conditionId {
            case 200...232:
                return "cloud.bolt.rain"
            case 300...321:
                return "cloud.drizzle"
            case 500...504:
                return "cloud.moon.rain"
            case 511...531:
                return "coud.heavyrain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "moon"
            case 801...802:
                return "cloud.moon"
            default:
                return "cloud"
            }
        }
    }
    
    
    
}
