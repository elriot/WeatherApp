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
    func fetchCurrentWeatherLive(completion: @escaping (CurrentWeather?) -> Void) {
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?lat=49.2827&lon=-123.1216&appid=439f13d919e90a6ab2080888652aea35&units=metric"
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

}
