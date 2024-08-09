//
//  PageControlCollectionViewCell.swift
//  YaWeather
//
//  Created by Vic on 14.05.2024.
//

import UIKit

class PageControlCollectionViewCell: UICollectionViewCell {
    static let identifier = "PageControlCollectionViewCell"

    lazy private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blueSky
        view.layer.cornerRadius = 10
        
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "map") // Убедитесь, что изображение добавлено в Assets
        backgroundImageView.contentMode = .scaleAspectFill // Настройка режима отображения изображения
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false // Используем Auto Layout
        backgroundImageView.layer.cornerRadius = 10
        
        // Добавляем UIImageView в контейнер
        view.addSubview(backgroundImageView)
        
        // Устанавливаем ограничения для UIImageView
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        return view
    }()
    
    lazy var textlabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(containerView)

        containerView.snp.makeConstraints({ make in
            make.leading.equalTo(10)
            make.top.equalTo(5)
            make.trailing.equalTo(-10)
            make.bottom.equalTo(-5)
        })
        containerView.addSubview(textlabel)
        textlabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
