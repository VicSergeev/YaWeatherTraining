//
//  NewVC.swift
//  YaWeather
//
//  Created by Admin on 27.04.2024.
//

import Foundation
import UIKit

final class NewVC: UIViewController {

	lazy private var dateLabel: UILabel = {
		var label = UILabel()
		label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
		label.text = "22 апреля"
		return label
	}()

//	init(day: DayModel?){
//		super.init(nibName: nil, bundle: nil)
//		
//		self.dateLabel.text = day?.day ?? "Херушки"
//	}
//	
//	required init?(coder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//	
	
	var day: DayModel? {
		didSet{
			guard let day else {
				self.dateLabel.text = "Херушки"
				return
			}

			self.dateLabel.text = day.date
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemMint
		
		view.addSubview(dateLabel)
		dateLabel.snp.makeConstraints({
			$0.center.equalToSuperview()
		})
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.setNavigationBarHidden(false, animated: false)
	}
	
}
