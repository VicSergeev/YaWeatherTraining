//
//  HourlyWeatherEndpoint.swift
//  YaWeather
//
//  Created by Vic on 26.06.2024.
//

import Foundation

//struct ParametersConstructor {
//    enum Scheme: String {
//        case https = "https:/"
//        case http = "http:/"
//    }
//    enum Version: String {
//        case v1, v2
//    }
//    
//    static func currentHourly(scheme: Scheme, domain: String, version: Version) -> String {
//        return [scheme.rawValue, domain, version.rawValue].joined(separator: "&")
//    }
//}

enum Answer: String {
    case yes = "yes"
    case no = "no"
}

enum DaysAmount: Int {
    case one = 1
}


// MARK: - ENDPOINT
enum HourlyWeatherEndpoint {
    case forecast(key: String, location: String, days: String, aqi: String, alerts: String)
}

extension HourlyWeatherEndpoint: Routing {
    
    var baseUrl: URL {
        switch self {
            
        case .forecast:
            return URL(string: URLConstructor.current(scheme: .https, domain: Configure.hourlyBaseUrl, version: .v1))!
        }
    }
    
    var path: String {
        return "/forecast.json"
    }
    
    var httpMethod: HTTPMethod {
        .GET
    }
    
    var headers: Headers? {
        return ["Accept": "*/*", "Accept-Encoding": "gzip, deflate, br", "Connection": "keep-alive", "User-Agent": "Vitek krasavchik kapitalnyj"]
    }
    
    var parameters: Parameters {
        switch self {
        case .forecast(let key, let location, let days, let aqi, let alerts):
            return ["key": key, "q": location, "days": days, "aqi": aqi, "alerts": alerts]
        }
    }
    
    var encoder: any ParameterEncodingProtocol {
        ParameterURLEncoder()
    }
    
    var task: HTTPTask {
        .requestURLParameters
    }
    
    
}
