//
//  DailyForecastCell.swift
//  WeatherApp
//
//  Created by SOOPIN KIM on 2024-07-27.
//

import UIKit

class DailyForecastCell: UICollectionViewCell {
    static let id = "DailyForecastCell"
    
    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    func configure(_ item: WeeklyForecastList){
        if let description = item.weather?.first?.main {
            let weather = WeatherType(description)
            img.image = weather.icon
            img.tintColor = weather.tint
        } else {
            img.image = nil
        }
        
        timeLabel.text = item.dt?.toHour()
        let tempInt: Int = Int(item.main?.temp ?? 0)
        temperatureLabel.text = "\(tempInt)°"
    }
}

