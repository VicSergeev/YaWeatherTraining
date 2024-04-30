//
//  CustomView.swift
//  YaWeather
//
//  Created by Vic on 30.04.2024.
//

import UIKit
import SnapKit

final class CustomView: UIView {
    
    // MARK: - Stack Views
    lazy private var mainStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.alignment = .center

        return stackView
    }()
    
    lazy private var headerStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .equalCentering
//        stackView.backgroundColor = .blue
        return stackView
    }()
    
    lazy private var footerStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = -55
//        stackView.backgroundColor = .red
        return stackView
    }()
    
    // MARK: - Contents
    lazy private var forecastTempLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        label.text = "+9°"
        return label
    }()
    
    lazy private var forecastIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        var image = UIImage(systemName: "cloud.sun")
        imageView.image = image
        
        return imageView
    }()
    
    lazy private var forecastDescription: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Облачно с прояснениями"
        return label
    }()
    
    lazy private var forecastFeelsLikeTemp: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
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
        
        // header
        headerStackView.axis = .horizontal
        headerStackView.distribution = .equalCentering
        headerStackView.alignment = .bottom
        
        // footer
        footerStackView.axis = .vertical
        footerStackView.distribution = .fillProportionally
        footerStackView.alignment = .center
        
        // put sub stacks into main stack
        mainStackView.addArrangedSubview(headerStackView)
        mainStackView.addArrangedSubview(footerStackView)
        
        // fill header stack with content
        headerStackView.addArrangedSubview(forecastTempLabel)
        headerStackView.addArrangedSubview(forecastIcon)
        
        // fill footer stack with contnt
        footerStackView.addArrangedSubview(forecastDescription)
        footerStackView.addArrangedSubview(forecastFeelsLikeTemp)
        
        // setup icon resolution
        forecastIcon.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
    }
}
