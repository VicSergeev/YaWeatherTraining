//
//  Base.swift
//  YaWeather
//
//  Created by Vic on 30.04.2024.
//
import UIKit
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
