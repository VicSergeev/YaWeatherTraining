//
//  DayWeatgetTableViewCell.swift
//  YaWeather
//
//  Created by Admin on 27.04.2024.
//

import UIKit
import SnapKit

//MARK: - ДЗ ( BaseTableViewCell в отдельный файл)

class BaseTableViewCell: UITableViewCell {
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		self.setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	func setupViews(){}
	
}



final class DayWeatgetTableViewCell: BaseTableViewCell {

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
	
	var day: DayModel? {
		didSet{
			guard let day else { return }
			self.dateLabel.text = day.date
			self.weekDayLabel.text = day.day
		}
	}
	
	//MARK: - ДЗ (добавить горизонтальный UIStackView, в него добавить картинку и 2 UILabel)
	
	override func setupViews(){
		self.addSubview(dateLabel)
		self.addSubview(weekDayLabel)

		dateLabel.snp.makeConstraints({
			$0.top.leading.equalToSuperview().offset(12)
		})
		
		weekDayLabel.snp.makeConstraints({ make in
			make.leading.equalTo(dateLabel)
			make.top.equalTo(dateLabel.snp.bottom).offset(4)
		})
	}
	
//	func configureCell(_ date: String, _ day: String){
//		self.dateLabel.text = date
//		self.weekDayLabel.text = day
//		
//	}
}
