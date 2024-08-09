//
//  ParameterURLEncoder.swift
//  YaWeather
//
//  Created by Vic on 02.06.2024.
//

import Foundation

public typealias Parameters = [String : Any]
public typealias Headers = [String: String]

public protocol ParameterEncodingProtocol {
    func encode(_ parameters: Parameters, request: inout URLRequest)
}

// MARK: - Encoders
struct ParameterURLEncoder: ParameterEncodingProtocol {
    func encode(_ parameters: Parameters, request: inout URLRequest) {
    
        // check if there are parameters are exist‼️
        // check if url exists‼️
        // create url components made of urlStr
        guard !parameters.isEmpty, let urlStr = request.url?.absoluteString, var urlComponents = URLComponents(string: urlStr) else {  return }
        
        let queryItems = parameters.map { // made of all contents from parameters‼️
            URLQueryItem(name: $0.key, value: String(describing: $0.value))
        }
        
        urlComponents.queryItems = queryItems
        
        request.url = urlComponents.url
    }
    
}


struct ParameterJSONEncoder: ParameterEncodingProtocol {
    func encode(_ parameters: Parameters, request: inout URLRequest) {
        guard !parameters.isEmpty else{return}
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = data
        } catch (let error) {
            print("JSONSerialization error: \(error.localizedDescription)")
        }
    }
}
