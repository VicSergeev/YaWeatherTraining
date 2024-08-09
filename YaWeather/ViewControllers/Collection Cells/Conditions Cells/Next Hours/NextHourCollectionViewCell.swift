//
//  NextHourCollectionViewCell.swift
//  YaWeather
//
//  Created by Vic on 16.05.2024.
//

import UIKit
// MARK: - ‼️  не пойму как сделать прозрачной
class NextHourCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NextHourCollectionViewCell"
    
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var tempLabel: UILabel!
    
    var hourlyCondition: HourlyForecast? {
        didSet {
            guard let hourlyCondition else { return }
            
            
            let temp = hourlyCondition.temp_c < 0 ? "-" : "+"
            tempLabel.text = "\(temp)\(hourlyCondition.temp_c)"
            
            
            // MARK: - dateformatter
            let dateString = hourlyCondition.time
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

            if let date = dateFormatter.date(from: dateString) {
                let calendar = Calendar.current
                let components = calendar.dateComponents([.hour, .minute], from: date)
                
                if calendar.dateComponents( [.hour], from: Date()).hour == components.hour {
                    timeLabel.text = "Now"
                }
                
                else if let hour = components.hour, let minute = components.minute {
                    timeLabel.text = String(format: "%02d:%02d", hour, minute)
                }
            } else {
                print("Неверный формат даты")
            }
            
            // MARK: - icons
            iconImageView.image = UIImage(systemName: hourlyCondition.condition?.text?.localizedValue ?? "")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

