//
//  ApinInfo.swift
//  WeatherApp
//
//  Created by SOOPIN KIM on 2024-07-30.
//

import Foundation

struct ApiInfo {
    static var apiKey: String? {
        return ProcessInfo.processInfo.environment["API_KEY"]
    }
}
