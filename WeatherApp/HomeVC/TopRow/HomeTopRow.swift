//
//  HomeTopRow.swift
//  WeatherApp
//
//  Created by SOOPIN KIM on 2024-07-27.
//

import UIKit

class HomeTopRow: UITableViewCell {
    static let id = "HomeTopRow"

    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var highLowLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ weather: CurrentWeather?) {
        guard let weather else { return }
        temperatureLabel.text = "\(weather.main.temp)"
        locationLabel.text = weather.name
        descriptionLabel.text = weather.weather.first?.description
        let low = weather.main.temp_min
        let high = weather.main.temp_max
        highLowLabel.text = "L:\(low)° | H:\(high)°"
        
        if let description = weather.weather.first?.main {
            let weather = WeatherType(description)
            img.image = weather.icon
        } else {
            img.image = nil
        }
    }
}
