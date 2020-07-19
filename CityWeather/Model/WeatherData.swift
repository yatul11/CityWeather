//
//  WeatherData.swift
//  CityWeather
//
//  Created by Ivan on 19.07.2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let sys: Sys
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let pressure: Double
    let humidity: Double
}

struct Wind: Codable {
    let speed: Double
}

struct Clouds: Codable {
    let all: Double
}

struct Sys: Codable {
    let sunrise: Double
    let sunset: Double
}

struct Weather: Codable {
    let description: String
    let main: String
    let id: Int
}
