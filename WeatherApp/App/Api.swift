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

}
