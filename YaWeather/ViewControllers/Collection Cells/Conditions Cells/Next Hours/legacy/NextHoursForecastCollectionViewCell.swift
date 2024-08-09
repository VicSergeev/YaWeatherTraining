////
////  NextHoursForecastCollectionViewCell.swift
////  YaWeather
////
////  Created by Vic on 08.05.2024.
////
//
//import UIKit
//
//class NextHoursForecastCollectionViewCell: UICollectionViewCell {
//    
//    static let identifier = "NextHoursForecastCollectionViewCell"
//    
//    lazy var stackView: UIStackView = {
//        let stack = UIStackView()
//        stack.spacing = 0
//        stack.axis = .vertical
//        stack.alignment = .center
//        stack.distribution = .fillEqually
//
//        return stack
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupViews(){
//        addSubview(stackView)
//
//        stackView.snp.makeConstraints({ make in
//            make.leading.top.bottom.trailing.equalToSuperview()
////            make.height.equalTo(120)
//            // тварь ебаная
//        })
//    }
//    
//    var hourlyConditions: [NextTwentyFourHoursModel]? {
//        
//        didSet {
//            guard let hourlyCondition = hourlyConditions?.first else { return } // Берем только первый элемент из массива
//
//            stackView.removeAll()
//
//            // Создаем ячейку с одним UILabel
//            let hourlyConditionView = NextHoursForecastView.instanceFromNib()
//            hourlyConditionView.hourlyCondition = hourlyCondition
//            stackView.addArrangedSubview(hourlyConditionView)
//
//            layoutIfNeeded()
//        }
//    }
//}

