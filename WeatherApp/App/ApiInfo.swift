//
//  ApiInfo.swift
//  WeatherApp
//
//  Created by SOOPIN KIM on 2024-07-29.
//

import Foundation

struct ApiInfo {
    func getApiKey() -> String? {
        return ProcessInfo.processInfo.environment["API_KEY"]
    }
}
