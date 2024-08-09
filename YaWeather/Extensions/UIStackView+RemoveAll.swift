//
//  UIStackView+RemoveAll.swift
//  YaWeather
//
//  Created by Admin on 11.05.2024.
//

import UIKit

extension UIStackView {
	
	func removeAll(){
		self.subviews.forEach {
			$0.removeFromSuperview()
		}
	}
}
