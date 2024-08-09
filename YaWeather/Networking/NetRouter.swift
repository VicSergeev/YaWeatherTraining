//
//  NetRouter.swift
//  YaWeather
//
//  Created by Vic on 02.06.2024.
//

// universal request for whole app

import Foundation

final class NetRouter<EndPoint: Routing>: NetworkRouter {
    func request(route: EndPoint, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void){
        // теперь здесь при вызове метода в fetchWeather, в route передаем Weather endpoint, он подписан под routing protocol
        // и он выдаст нам что на нашем распоряжении case forecast из Weather endpoint
        var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 500.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        switch route.task {
            
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .requestBodyParameters:
            route.encoder.encode(route.parameters, request: &request)
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .requestURLParameters:
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            route.encoder.encode(route.parameters, request: &request)
        case .requestURLAndBodyParameters:
            break
        }
        
        
        route.headers?.forEach { //(key: String, value: String) in
            request.setValue($1, forHTTPHeaderField: $0)
        }
        
        NetworkLogger.log(request: request)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }
}
