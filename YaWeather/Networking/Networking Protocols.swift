//
//  Networking Protocols.swift
//  YaWeather
//
//  Created by Vic on 08.06.2024.
//

import Foundation


// MARK: - Routing protocol
protocol Routing {
    var baseUrl: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: Headers? { get }
    var parameters: Parameters { get }
    var encoder: ParameterEncodingProtocol { get }
    var task: HTTPTask{ get }
}

extension Routing {
    var baseUrl: URL { // if default value is set thenfore in WeatherEndPoint won't ask to create var baseUrl‼️
        return URL(string: URLConstructor.current(scheme: .https, domain: Configure.baseUrl, version: .v2))!
        // baseUrl can be override if needed in any type that conform Routing protocol‼️
    }
}




// MARK: - NetRouter protocol
protocol NetworkRouter {
//    associatedtype по факту это какой-то дженерик
    associatedtype EndPoint: Routing // любой тип данных или класс может быть подписан на роутинг
    func request(route: EndPoint, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}
