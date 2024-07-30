//
//  WeatherType.swift
//  WeatherApp
//
//  Created by SOOPIN KIM on 2024-07-29.
//

import Foundation
import UIKit

enum WeatherType {
    case sunny, clear, cloudy, rainy, windy, snowy, foggy, misty, none
    
    init(_ description: String){
        switch description.lowercased(){
        case let str where str.contains("sun"):
            self = .sunny
        case let str where str.contains("clear"):
            self = .clear
        case let str where str.contains("cloud"):
            self = .cloudy
        case let str where str.contains("rain"):
            self = .rainy
        case let str where str.contains("windy"):
            self = .windy
        case let str where str.contains("snow"):
            self = .snowy
        case let str where str.contains("fog"):
            self = .foggy
        case let str where str.contains("mist"):
            self = .misty
        default:
            self = .none
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .sunny, .clear:
            return UIImage(systemName: "sun.max.fill")
        case .cloudy:
            return UIImage(systemName: "cloud.fill")
        case .rainy:
            return UIImage(systemName: "cloud.rain.fill")
        case .windy:
            return UIImage(systemName: "wind")
        case .snowy:
            return UIImage(systemName: "snowflake")
        case .foggy, .misty:
            return UIImage(systemName: "cloud.fog.fill")
        case .none:
            return nil
        }
    }
}
