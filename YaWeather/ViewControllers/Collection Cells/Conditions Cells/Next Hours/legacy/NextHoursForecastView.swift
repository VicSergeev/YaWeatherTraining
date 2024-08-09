//
//  NextHoursForecastView.swift
//  YaWeather
//
//  Created by Vic on 14.05.2024.
//

import UIKit

class NextHoursForecastCollectionViewCell: UICollectionViewCell {
    static let identifier = "NextHoursForecastCollectionViewCell"
    
    
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var tempLabel: UILabel!
    
    var hourlyCondition: NextTwentyFourHoursModel? {
        didSet {
            guard let hourlyCondition else { return }
            tempLabel.text = hourlyCondition.temperature
        }
    }
}
