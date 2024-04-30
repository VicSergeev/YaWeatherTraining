//
//  ViewController.swift
//  YaWeather
//
//  Created by Vic on 30.04.2024.
//

import UIKit
import SnapKit

final class HeaderTableViewCell: BaseTableViewCell {
    
    private let customView = CustomView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
