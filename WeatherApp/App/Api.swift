//
//  Api.swift
//  WeatherApp
//
//  Created by SOOPIN KIM on 2024-07-28.
//

import Foundation

class Api {
    static let shared = Api()
    private init(){}
    private let apiInfo = ApiInfo()
    let seattle: String = "CurrentWeather"
    let vancouver: String = "CurrentWeatherVancouver"
    
    // sample data
    func fetchCurrentWeather(completion: @escaping (CurrentWeather?) -> Void) {
        guard let path = Bundle.main.path(forResource: vancouver, ofType: "json") else {
            completion(nil)
            return
        }
        let url = URL(filePath: path)
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url)
            let decodeData = try decoder.decode(CurrentWeather.self, from: data)
            completion(decodeData)
        } catch {
            print(error)
            completion(nil)
        }
    }
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping(CurrentWeather?) -> Void){
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(ApiInfo.key)&units=metric"
        let url = URL(string: urlStr)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data else {
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodeData = try decoder.decode(CurrentWeather.self, from: data)
                completion(decodeData)
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
    
    // get live data calling api
    func fetchCurrentWeatherLive(completion:
                                 @escaping (CurrentWeather?) -> Void) {
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?lat=49.2827&lon=-123.1216&appid=\(ApiInfo.key)&units=metric"
        let url = URL(string: urlStr)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data else {
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodeData = try decoder.decode(CurrentWeather.self, from: data)
                completion(decodeData)
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
    
    // sample data
    func fetchWeeklyForecast(completion: @escaping (WeeklyForecast?) -> Void) {
        guard let path = Bundle.main.path(forResource: "WeeklyForecast", ofType: "json") else {
            completion(nil)
            return
        }
        let url = URL(filePath: path)
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url)
            let decodeData = try decoder.decode(WeeklyForecast.self, from: data)
            completion(decodeData)
        } catch {
            print(error)
            completion(nil)
        }
    }
    
    
    func fetchSample<T: Decodable>(_ type: T.Type, completion: @escaping (T?) -> Void) {
        let resource = getResourceName(type)
        guard let path = Bundle.main.path(forResource: resource, ofType: "json") else {
            completion(nil)
            return
        }
        let url = URL(filePath: path)
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try decoder.decode(
                type,
                from: data)
            completion(decodedData)
        } catch {
            print(error)
            completion(nil)
        }
    }
    
    private func getResourceName<T>(_ type: T.Type) -> String {
        return switch type {
        case is CurrentWeather.Type:
            "CurrentWeatherVancouver"
        case is WeeklyForecast.Type:
            "WeeklyForecast"
        case is [SearchLocation].Type:
            "SearchLocation"
        default:
            ""
        }
    }
}

extension [WeeklyForecastList] {
    func getDailyForecasts() -> [DailyForecast] {
        var dailyForecasts: [DailyForecast] = []
        for item in self {
            guard let dt = item.dt?.toDay(), let low = item.main?.tempMin, let high = item.main?.tempMax else { continue }

            guard dailyForecasts.count > 0 else {
                let newDay = parse(using: item)
                dailyForecasts.append(newDay)
                continue
            }

            if dailyForecasts.last?.day == dt {
                let j = dailyForecasts.count - 1
                dailyForecasts[j].lows.append(low)
                dailyForecasts[j].highs.append(high)
            } else {
                let newDay = parse(using: item)
                dailyForecasts.append(newDay)
            }
        }
        return dailyForecasts
    }
    
    private func parse(using item: WeeklyForecastList) -> DailyForecast {
        var forecast = DailyForecast(day: item.dt!.toDay(), description: item.weather!.first?.main, dt_txt: item.dt_txt)
//        var forecast = DailyForecast(day: item.dt!.toDay(), description: item.weather!.first?.main)
        forecast.lows.append(item.main!.tempMin!)
        forecast.highs.append(item.main!.tempMax!)
        return forecast
    }
}
