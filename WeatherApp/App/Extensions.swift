//
//  Extensions.swift
//  WeatherApp
//
//  Created by SOOPIN KIM on 2024-07-29.
//

import Foundation
import UIKit

extension [Double] {
    func average() -> Double {
        var total: Double = 0
        var count: Double = 0
        for num in self {
            total += num
            count += 1
        }
        return total / count
    }
}

extension Int {
    func toDay() -> String {
        let date = Date(timeIntervalSince1970: Double(self))
        return date.formatted(Date.FormatStyle().weekday(.abbreviated))
    }
    
    func toHour() -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("h:mm")
        
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        let date = Date(timeIntervalSince1970: Double(self))
        return formatter.string(from: date)
    }
}

extension UIViewController {
    func pushVC(_ vc: UIViewController?){
        guard let newVC = vc else { return }
        navigationController?.pushViewController(newVC, animated: true)
    }
}

