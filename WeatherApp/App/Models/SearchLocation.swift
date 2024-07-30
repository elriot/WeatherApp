//
//  SearchLocation.swift
//  WeatherApp
//
//  Created by SOOPIN KIM on 2024-07-30.
//

import Foundation

struct SearchLocation: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
}

