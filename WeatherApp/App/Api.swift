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
    private let test = "test"
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
    
    // get live data calling api
    func fetchCurrentWeatherLive(completion:
                                 @escaping (CurrentWeather?) -> Void) {
        guard let apiKey = apiInfo.getApiKey() else {
            print("API key not found")
            completion(nil)
            return
        }
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?lat=49.2827&lon=-123.1216&appid=\(apiKey)&units=metric"
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
    
    func sampleFunction(int: Int){
        
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
        default:
            ""
        }
    }

}
