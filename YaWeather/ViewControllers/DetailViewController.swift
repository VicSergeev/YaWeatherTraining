//
//  NewVC.swift
//  YaWeather
//
//  Created by Admin on 27.04.2024.
//

import UIKit

final class DetailViewController: UIViewController {

	lazy private var dateLabel: UILabel = {
		var label = UILabel()
		label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
		label.text = "22 апреля"
		return label
	}()
	
	var day: DayModel? {
		didSet {
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
