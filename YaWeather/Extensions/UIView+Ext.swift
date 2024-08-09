//
//  UIView+Ext.swift
//  YaWeather
//
//  Created by Vic on 23.04.2024.
//

import UIKit
import Foundation

extension UIView {
    
//    func loadViewFromNib(nibName: String) -> UIView? {
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: nibName, bundle: bundle) // нибнэйб было бы удобнее передать сюда как название класса,
//        // для этого пишем расширение 
//        return nib.instantiate(withOwner: self, options: nil).first as? UIView
//    }
    
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints                             = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive           = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive   = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive     = true
    }
    
        /// Class name of UIView child object as string
        var className: String {
            return String(describing: type(of: self))
        }
        
        // MARK: - создаем class var className который будет возвращать имя класса в виде String 0️⃣
        /// Class name of UIView child class as string
        class var className: String {
            return String(describing: self)
        }
        
}
