//
//  CurrentConditionView.swift
//  YaWeather
//
//  Created by Admin on 11.05.2024.
//

import UIKit

final class CurrentConditionView: UIView, InstanceFromNibProtocol {
    typealias InstanceFromNibType = CurrentConditionView
    
    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    
    //	var condition: CurrentConditionsModel? {
    //		didSet {
    //			guard let condition else{ return }
    //			iconImageView.image = condition.image
    //			titleLabel.text = condition.description
    //		}
    //	}
    
    func fill(image: UIImage, title: String){
        iconImageView.image = image
        titleLabel.text = title
    }
    
}
