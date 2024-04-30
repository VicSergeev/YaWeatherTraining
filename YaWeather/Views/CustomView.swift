//
//  CustomView.swift
//  YaWeather
//
//  Created by Vic on 30.04.2024.
//

import UIKit
import SnapKit

final class CustomView: UIView {
    
//    private let mainStackView = UIStackView()
//    private let headerStackView = UIStackView()
//    private let footerStackView = UIStackView()
    
    // MARK: - Stack Views
    lazy private var mainStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    lazy private var headerStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 1
        return stackView
    }()
    
    lazy private var footerStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    // MARK: - Contents
    lazy private var forecastTempLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .medium)
        label.text = "+9°"
        return label
    }()
    
    lazy private var forecastIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        var image = UIImage(systemName: "cloud.sun")
        imageView.image = image
        return imageView
    }()
    
    lazy private var forecastDescription: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.text = "Облачно с прояснениями"
        return label
    }()
    
    lazy private var forecastFeelsLikeTemp: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 9, weight: .medium)
        label.text = "Ощущается как +3°"
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        guard let view = self.loadViewFromNib(nibName: "CustomView") else { return }
        view.frame = bounds
        addSubview(view)
        
        addSubview(mainStackView)
        addSubview(forecastTempLabel)
        addSubview(forecastIcon)
        addSubview(forecastDescription)
        addSubview(forecastFeelsLikeTemp)
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // main stack setup
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .center
        
        // put sub stacks into main stack
        mainStackView.addArrangedSubview(headerStackView)
        mainStackView.addArrangedSubview(footerStackView)
        
        // fill header stack with content
        headerStackView.addArrangedSubview(forecastTempLabel)
        headerStackView.addArrangedSubview(forecastIcon)
        
        // fill footer stack with contnt
        footerStackView.addArrangedSubview(forecastDescription)
        footerStackView.addArrangedSubview(forecastFeelsLikeTemp)
    }
}
