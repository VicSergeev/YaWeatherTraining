//
//  CustomView.swift
//  YaWeather
//
//  Created by Vic on 30.04.2024.
//

import UIKit
import SnapKit
import SwiftDraw
import Kingfisher


//extension UIView {
//    /// Class name of UIView child object as string
//    var className: String { // специальная переменная, может быть важна для класса
//        return String(describing: type(of: self))
//    }
//    
//    // MARK: - создаем class var className который будет возвращать имя класса в виде String 0️⃣
//    /// Class name of UIView child class as string
//    class var className: String {
//        return String(describing: self)
//    }
//    
//}
// MARK: - Вместо awakeFromNib() создаем этот протокол 1️⃣
// MARK: - InstanceFromNibProtocol
protocol InstanceFromNibProtocol {
    
    // MARK: - Assissiated type
    associatedtype InstanceFromNibType: UIView // associatedtype используются непосредственно в протоколах для создания ассоциации типа
    // этот тип из протокола в дальнейшем создаст псевдоним типа который будет использован в классе
    /// - Returns: UIView instance
    ///
    static func instanceFromNib() -> InstanceFromNibType // метод будет возвращать экземпляр UIView из nib
    // InstanceFromNibType в свою очередь становится носителем UIView, псевдонимом для UIView
    
}
// InstanceFromNibProtocol

// MARK: - Создаем расширение в котром реализуем метод протокола 2️⃣
extension InstanceFromNibProtocol {
    static func instanceFromNib() -> InstanceFromNibType { // associatedtype InstanceFromNibType: UIView
        // MARK: - этот же код можно закомментить в расширении для UIView
        let nibName = InstanceFromNibType.className // class var className: String {return String(describing: self)}
        let nib = UINib(nibName: nibName, bundle: nil) // bundle: nil - вместо константы для бандл
        
        return (nib.instantiate(withOwner: self, options: nil).first as? InstanceFromNibType) ?? InstanceFromNibType()
    }
}



final class CustomView: UIView, InstanceFromNibProtocol { // подписали класс под наш протокол InstanceFromNibProtocol 3️⃣
    // в протоколе есть ассоциативный тип InstanceFromNibType
    typealias InstanceFromNibType = CustomView // протокол создает для него псевдоним в который мы передаем кастом вью
    // с которым будет работать тип
    
    // 4️⃣
    // а так как в расширении для протокола реализован метод этого протокола,
    // и текущий класс подписан под этот протокол, соответственно и под его расширение тоже
    // в текущем классе достаточно одной строки typealias InstanceFromNibType = CustomView
    // для того, чтобы все заработало, а именно: отобразились те элементы интерфейса
    // которые были созданы в XIB файле
    // ПРОДОЛЖЕНИЕ в Header
    
    
    // MARK: - Stack Views Programatically
    //    lazy private var mainStackView: UIStackView = {
    //        var stackView = UIStackView()
    //        stackView.axis = .horizontal
    //        stackView.spacing = 1
    //        stackView.alignment = .center
    //
    //        return stackView
    //    }()
    //
    //    lazy private var headerStackView: UIStackView = {
    //        var stackView = UIStackView()
    //        stackView.axis = .horizontal
    //        stackView.spacing = 20
    //        stackView.alignment = .center
    //        stackView.distribution = .equalCentering
    //        stackView.backgroundColor = .blue
    //        return stackView
    //    }()
    //
    //    lazy private var footerStackView: UIStackView = {
    //        var stackView = UIStackView()
    //        stackView.axis = .vertical
    //        stackView.spacing = -55
    //        stackView.backgroundColor = .red
    //        return stackView
    //    }()
    
    // MARK: - Contents
    
    @IBOutlet weak var forecastTempLabel: UILabel! // made using XIB
    
    
    //    lazy private var forecastTempLabel: UILabel = {
    //        var label = UILabel()
    //        label.font = UIFont.systemFont(ofSize: 40, weight: .medium)
    //        label.text = "+9°"
    //        return label
    //    }()
    
    @IBOutlet weak var forecastIcon: UIImageView!
    
    //    lazy private var forecastIcon: UIImageView = {
    //        var imageView = UIImageView()
    //        imageView.contentMode = .scaleAspectFit
    //
    //        var image = UIImage(systemName: "cloud.sun")
    //        imageView.image = image
    //
    //        return imageView
    //    }()
    //
    @IBOutlet weak var forecastDescription: UILabel! // made using XIB
    
    //	lazy private var forecastDescription: UILabel = {
    //        var label = UILabel()
    //        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    //        label.text = "Облачно с прояснениями"
    //        return label
    //    }()
    
    @IBOutlet weak var forecastFeelsLikeTemp: UILabel! // made using XIB
    //    lazy private var forecastFeelsLikeTemp: UILabel = {
    //        var label = UILabel()
    //        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
    //        label.text = "Ощущается как +3°"
    //        return label
    //    }()
    
    func fill(_ fact: Fact) {
        
        let networkManager = NetworkManager()
        
        forecastTempLabel.text = "\( fact.temp <= 0 ? "" : "+")\(fact.temp)"
        forecastDescription.text = "\(fact.condition?.localizedValue ?? "")"
        forecastFeelsLikeTemp.text = "Ощущается как \(fact.feelsLike <= 0 ? "" : "+")\(fact.feelsLike)"
        
        
        // here method caller
        let path = "https://yastatic.net/weather/i/icons/funky/dark/\(fact.icon).svg"
        
        forecastIcon.kf.setImage(with: URL(string: path), options: [.processor(SVGImgProcessor())])
  
        
//        networkManager.fetchImage(name: fact.icon) { data, error in
//            
//            
//            if let data = data, let image = UIImage(svgData: data) {
//                
//                DispatchQueue.main.async {
//                    self.forecastIcon.image = image
//                }
//            } else {
//                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
//            }
//            
//        }
    }
}
//	override func awakeFromNib() { // но и этот метод не нужен потому что ②
//		super.awakeFromNib()
//	}
//


// MARK: - Initializers - не нужны так как у нас xib и awakeFromNib ⓵
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupUI()
//    }

// MARK: - Private methods
//    private func setupUI() {
//        guard let view = self.loadViewFromNib(nibName: "CustomView") else { return }
//        view.frame = bounds
//        addSubview(view)
//
//////        addSubview(mainStackView)
////        addSubview(forecastTempLabel)
////        addSubview(forecastIcon)
////        addSubview(forecastDescription)
////        addSubview(forecastFeelsLikeTemp)
////
//////        mainStackView.snp.makeConstraints { make in
////            make.edges.equalToSuperview()
////        }
//
//        // main stack setup
////        mainStackView.axis = .vertical
////        mainStackView.distribution = .fillEqually
////        mainStackView.alignment = .center
////
//        // header
//        headerStackView.axis = .horizontal
//        headerStackView.distribution = .equalCentering
//        headerStackView.alignment = .bottom
//
//        // footer
//        footerStackView.axis = .vertical
//        footerStackView.distribution = .fillProportionally
//        footerStackView.alignment = .center
//
//        // put sub stacks into main stack
//        mainStackView.addArrangedSubview(headerStackView)
//        mainStackView.addArrangedSubview(footerStackView)
//
//        // fill header stack with content
//        headerStackView.addArrangedSubview(forecastTempLabel)
//        headerStackView.addArrangedSubview(forecastIcon)
//
//        // fill footer stack with contnt
//        footerStackView.addArrangedSubview(forecastDescription)
//        footerStackView.addArrangedSubview(forecastFeelsLikeTemp)
//
//        // setup icon resolution
//        forecastIcon.snp.makeConstraints { make in
//            make.width.equalTo(80)
//            make.height.equalTo(80)
//        }
//    }


public struct SVGImgProcessor:ImageProcessor {
//    public var identifier: String
    
    public var identifier: String = "com.appidentifier.webpprocessor"
    public func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            print("already an image")
            return image
        case .data(let data):
//            let imsvg = SVGKImage(data: data)
            return UIImage(svgData: data)
        }
    }
}

//imageView.kf.setImage(with: imURL, options: [.processor(SVGImgProcessor())])
