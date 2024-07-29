//
//  HomeWeeklyForecastRow.swift
//  WeatherApp
//
//  Created by SOOPIN KIM on 2024-07-27.
//

import UIKit

class HomeWeeklyForecastRow: UITableViewCell {
    static let id = "HomeWeeklyForecastRow"
    private var dailyForecast: [DailyForecast] = []
    
    @IBOutlet private weak var tableView: UITableView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configure(_ forecast: WeeklyForecast?) {
        guard let list = forecast?.list else { return }
        dailyForecast = list.getDailyForecasts()
        tableView.reloadData()
    }
}

extension HomeWeeklyForecastRow: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("daily forecast count", dailyForecast.count)
        return dailyForecast.count > 5 ? 5 : dailyForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeeklyForecastDetailRow.id) as! WeeklyForecastDetailRow
        let forcast = dailyForecast[indexPath.row]
        cell.configure(forcast)
        return cell
    }
}

extension HomeWeeklyForecastRow: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
