//
//  DayWeatgetTableViewCell.swift
//  YaWeather
//
//  Created by Admin on 27.04.2024.
//

import UIKit
import SnapKit

// MARK: - tableview weather list
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
    
    lazy private var forecastDetailStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.backgroundColor = .init(white: 1, alpha: 0.3)
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
	
    //MARK: - ДЗ (сделать сепаратор на всю длину)✅
	lazy private var separatorView: UIView = {
		let view = UIView()
		view.backgroundColor = .lightGray.withAlphaComponent(0.5)
		return view
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
		self.addSubview(separatorView)
		forecastDetailStackView.addArrangedSubview(forecastImage)
		forecastDetailStackView.addArrangedSubview(forecastCurrentTempLabel)
		forecastDetailStackView.addArrangedSubview(forecastNightTempLabel)
		
		
		dateLabel.snp.makeConstraints({
			$0.top.leading.equalToSuperview().offset(12)
		})
		
		weekDayLabel.snp.makeConstraints({ make in
			make.leading.equalTo(dateLabel)
			make.top.equalTo(dateLabel.snp.bottom).offset(4)
			
		})
        
        forecastDetailStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
	
		separatorView.snp.makeConstraints { make in
			make.top.equalTo(weekDayLabel.snp.bottom).offset(11)
			make.leading.trailing.bottom.equalToSuperview()
			make.height.equalTo(0.5)
		}
	}
	
//	func configureCell(_ date: String, _ day: String){
//		self.dateLabel.text = date
//		self.weekDayLabel.text = day
//		
//	}
}
