//
//  DayWeatgetTableViewCell.swift
//  YaWeather
//
//  Created by Admin on 27.04.2024.
//

import UIKit
import SnapKit

final class DayWeatherTableViewCell: BaseTableViewCell {

	lazy private var dateLabel: UILabel = {
		var label = UILabel()
		label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
		label.text = "22 апреля"
		label.textColor = .systemGray
		return label
	}()

	
	lazy private var weekDayLabel: UILabel = {
		var label = UILabel()
		label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
		label.text = "Сегодня"
		return label
	}()
    
    //MARK: - ДЗ (добавить горизонтальный UIStackView, в него добавить картинку и 2 UILabel) ✅
    
    lazy private var forecastDetailStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    lazy private var forecastImage: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        var image = UIImage(systemName: "cloud.sun")
        imageView.image = image
        return imageView
    }()
    
    lazy private var forecastCurrentTempLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "+17°"
        return label
    }()
    
    lazy private var forecastNightTempLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = .systemGray
        label.text = "+9°"
        return label
    }()
	
    // HOME TASK END
    
	var day: DayModel? {
		didSet{
			guard let day else { return }
			self.dateLabel.text = day.date
			self.weekDayLabel.text = day.day
		}
	}
	
	override func setupViews(){
		self.addSubview(dateLabel)
		self.addSubview(weekDayLabel)
        self.addSubview(forecastDetailStackView)

		dateLabel.snp.makeConstraints({
			$0.top.leading.equalToSuperview().offset(12)
		})
		
		weekDayLabel.snp.makeConstraints({ make in
			make.leading.equalTo(dateLabel)
			make.top.equalTo(dateLabel.snp.bottom).offset(4)
		})
        
        forecastDetailStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(4)
        }
        forecastDetailStackView.addArrangedSubview(forecastImage)
        forecastDetailStackView.addArrangedSubview(forecastCurrentTempLabel)
        forecastDetailStackView.addArrangedSubview(forecastNightTempLabel)
	}
	
//	func configureCell(_ date: String, _ day: String){
//		self.dateLabel.text = date
//		self.weekDayLabel.text = day
//		
//	}
}
