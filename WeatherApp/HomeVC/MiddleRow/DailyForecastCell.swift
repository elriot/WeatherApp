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
    
    func configure(){
        
    }
}
