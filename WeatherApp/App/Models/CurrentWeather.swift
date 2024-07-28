//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by SOOPIN KIM on 2024-07-28.
//

import Foundation

struct CurrentWeather: Decodable{
    let coord: Coordinates
    let weather: [CurrentWeatherWeather]
    let base: String
    let main: CurrentWeatherMain
    let visibility: Int
    let wind: CurrentWeatherWind
    let clouds: CurrentWeatherClouds
    let dt: Int
    let sys: CurrentWeatherSys
    let timezone: Int
    let id: Int
    let name: String
    let code: Int
}



struct Coordinates {
    let lon: Double
    let lat: Double
}

struct CurrentWeatherWeather {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct CurrentWeatherMain {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int
    let grnd_level: Int
}

struct CurrentWeatherWind {
    let speed: Double
    let deg: Int
}

struct CurrentWeatherClouds {
    let all: Int
}

struct CurrentWeatherSys {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
