//
//  CurrentConditionsCollectionViewCell.swift
//  YaWeather
//
//  Created by Vic on 08.05.2024.
//

import UIKit
// MARK: - view where is wind
class CurrentConditionsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CurrentConditionsCollectionViewCell"
	
	lazy var stackView: UIStackView = {
		let stack = UIStackView()
		stack.spacing = 7
		stack.axis = .vertical
		stack.alignment = .fill
		stack.distribution = .fillEqually
		return stack
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupViews()
        // call method
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupViews() {
		addSubview(stackView)
		
		stackView.snp.makeConstraints({
			$0.leading.trailing.centerY.equalToSuperview()
			$0.top.greaterThanOrEqualToSuperview()
			$0.bottom.lessThanOrEqualToSuperview()
		})
	}
    
	var conditions: CurrentInfoResponse? {
		
		didSet {
			guard let conditions else { return }
			stackView.removeAll()
            let windView = CurrentConditionView.instanceFromNib()
            windView.fill(image: UIImage(systemName: "wind")!, title: "\(conditions.wind_kph) км/ч")
            
            let pressureView = CurrentConditionView.instanceFromNib()
            let roundedPressure = conditions.pressure_mb.rounded()
            pressureView.fill(image: UIImage(systemName: "aqi.medium")!, title: "\(String(format: "%.1f", roundedPressure)) гПк")
            
            let humidityView = CurrentConditionView.instanceFromNib()
            humidityView.fill(image: UIImage(systemName: "humidity")!, title: "\(conditions.humidity) %")
            
            let dewPointView = CurrentConditionView.instanceFromNib()
            dewPointView.fill(image: UIImage(systemName: "thermometer.medium")!, title: "\(conditions.dewpoint_c) °C")
            
            stackView.addArrangedSubview(windView)
            stackView.addArrangedSubview(pressureView)
            stackView.addArrangedSubview(humidityView)
            stackView.addArrangedSubview(dewPointView)
            
            layoutIfNeeded()
        }
	}
}
