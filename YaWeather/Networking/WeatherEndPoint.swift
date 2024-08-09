//
//  WeatherEndPoint.swift
//  YaWeather
//
//  Created by Vic on 08.06.2024.
//

import Foundation

// это надо выносить в отдельный файл?‼️
struct Configure {
    static let baseUrl = "api.weather.yandex.ru"
    static let iconURL = "yastatic.net"
    static let apiKey = "8f4dae66-ed25-45f2-bec4-2f8b8fa1f872"
    static let hourlyWeatherAPIKey = "76490bdb48e7425a973141321242606"
    static let hourlyBaseUrl = "api.weatherapi.com"
}

struct URLConstructor{
    enum Scheme: String {
        case https = "https:/"
        case http = "http:/"
    }
    enum Version: String {
        case v1, v2
    }
    
    static func current(scheme: Scheme, domain: String, version: Version? = nil) -> String {
        guard let version else {
            return [scheme.rawValue, domain].joined(separator: "/")
        }
        return [scheme.rawValue, domain, version.rawValue].joined(separator: "/")
    }
}

enum HTTPMethod: String {
    case POST, PUT, GET, DELETE
}

// типы передаваемых параметров
enum HTTPTask {
    case request
    case requestBodyParameters
    case requestURLParameters
    case requestURLAndBodyParameters
}

// это надо выносить в отдельный файл?‼️

// MARK: - Endpoint
enum WeatherEndPoint {
    case forecast(lat: String, lon: String)
    case image(name: String)
    // daily weekly next 12 hours cases to be called inside NetRouter<WeatherEndPoint>().request(right here✅) what is nested in NetworkManager ‼️
}

// MARK: - ENUM

extension WeatherEndPoint: Routing {
    
    var baseUrl: URL {
        switch self {
        case .forecast:
            return URL(string: URLConstructor.current(scheme: .https, domain: Configure.baseUrl, version: .v2))!
        case .image:
            //"https://yastatic.net/weather/i/icons/funky/dark/\(name).svg"
            return URL(string: URLConstructor.current(scheme: .https, domain: Configure.iconURL))!
        }
    }
    
    var task: HTTPTask {
        .requestURLParameters
        // ‼️ сюда передаем кейс какие параметры запроса будут использованы
        // а хэдэры если есть то есть-они опциональные в протоколе routing
        // и если они есть вносим их по очереди в риквест внутри NetRouter
    }
    
    var encoder: any ParameterEncodingProtocol {
        ParameterURLEncoder()
    }
    
    var httpMethod: HTTPMethod {
        .GET
    }
    
    var headers: Headers? {
        return ["X-Yandex-API-Key": Configure.apiKey]
    }
    
    var path: String {
        switch self {
            
        case .forecast:
            return "/informers"
        case .image(let name):
            return "/weather/i/icons/funky/dark/\(name).svg"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .forecast(let lat, let lon):
            return ["lat": lat,
                    "lon": lon
            ]
        case .image:
            return [:]
        }
    }
}
