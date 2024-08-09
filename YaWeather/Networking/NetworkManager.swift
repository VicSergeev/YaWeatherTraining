//
//  NteworkManager.swift
//  YaWeather
//
//  Created by Vic on 24.05.2024.
//

import Foundation

enum Result<String> {
    case success
    case failure(Error)
}

enum NetworkResponse: Error {
    case success
    case authenticationError
    case badRequest
    case outdate
    case failed
    case noData
    case unableToDecode
    case authenticationIncorrect
    case username
    case email

}

extension NetworkResponse: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .authenticationError:
            return NSLocalizedString("You need to be authenticated first.", comment: "")
            
        case .badRequest:
            return NSLocalizedString("Bad request.", comment: "")
            
        case .outdate:
            return NSLocalizedString("The url you requested is outdated.", comment: "")
            
        case .failed:
            return NSLocalizedString("Network reqest failed.", comment: "")
            
        case .noData:
            return NSLocalizedString("Response returned with no data to decode.", comment: "")
            
        case .unableToDecode:
            return NSLocalizedString("We could not decode the response.", comment: "")
            
        case .authenticationIncorrect:
            return NSLocalizedString("Incorrect email or password entered.", comment: "")
            
        case .username:
            return NSLocalizedString("Username field must be unique.", comment: "")
            
        case .email:
            return NSLocalizedString("E-mail field must be unique.", comment: "")
        default: return nil
        }
    }
}


// MARK: - NetworkManager protocol
protocol NetworkManagerProtocol {
    
    func handleNetwork(_ response: HTTPURLResponse) -> Result<String>
}
extension NetworkManagerProtocol {
    func handleNetwork(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError)
        case 501...599: return .failure(NetworkResponse.badRequest)
        case 600: return .failure(NetworkResponse.outdate)
        default: return .failure(NetworkResponse.failed)
        }
    }
}


protocol WeatherNetworkManagerProtocol: NetworkManagerProtocol {
    typealias WeatherCompletion = (_ weather: WeatherData?, _ error: Error?) -> Void
    typealias IconCompletion = (Data?, Error?) -> Void
    typealias HourlyCompletion = (/*_ data: Data,*/ _ weather: ForecastResponse?, _ error: Error?) -> Void
    
    func fetchWeather(lat: String, lon: String, completion: @escaping WeatherCompletion)
    func fetchImage(name: String, completion: @escaping IconCompletion)
    func fetchHourly(key: String, location: String, days: String, aqi: String, alerts: String, completion: @escaping HourlyCompletion)
    
    // MARK: - ‼️‼️‼️‼️ fetchData for CurrentConditions model???? ‼️‼️‼️‼️
    // let currentConditions = try decoder.decode([CurrentConditionsModel].self, from: data)
}

// MARK: - Network Manager
class NetworkManager: WeatherNetworkManagerProtocol {
    
    func fetchHourly(key: String, location: String, days: String, aqi: String, alerts: String, completion: @escaping HourlyCompletion) {
        NetRouter<HourlyWeatherEndpoint>().request(
            route: .forecast(
                key: key,
                location: location,
                days: days,
                aqi: aqi,
                alerts: alerts
            )) { data, response, error in
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, error)
                    return
                }
                
                switch self.handleNetwork(response) {
                case .success:
                    guard let data else {
                        completion(nil, NetworkResponse.noData)
                        return
                    }
                    
                    print(String(data: data, encoding: .utf8))
                    
                    // ебаный парсер попытка сука 12
                    self.parseResponse(data: data, responseType: ForecastResponse.self) { (decodedData: ForecastResponse?, error) in
                        if let error = error {
                            completion(nil, NetworkResponse.unableToDecode)
                        } else {
                            // обработка успешно распарсенных данных
                            completion(decodedData, nil)
                        }
                    }
                    // MARK: - я его рот ебал
//                    let decoder = JSONDecoder()
//                    decoder.dateDecodingStrategy = .secondsSince1970
//                    do {
//                        let decodeData = try decoder.decode(ForecastResponse.self, from: data)
//                        completion(decodeData, nil)
//                    } catch {
//                        completion(nil, NetworkResponse.unableToDecode)
//                    }
                    
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
    
    
    func fetchImage(name: String, completion: @escaping IconCompletion) {
        NetRouter<WeatherEndPoint>().request(route: .image(name: name)) { data, _, error in
            
            guard let data = data else {
                completion(nil, NSError(domain: "Data Error", code: 0, userInfo: nil))
                return
            }
            
            completion(data, nil)
        }
        
        //        guard let imageUrl = URL(string: url) else {
//            completion(nil, URLError(.badURL))
//            return
//        }
//        
//        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
//            if let error = error {
//                completion(nil, error)
//                return
//            }
//            
//            guard let data = data else {
//                completion(nil, NSError(domain: "Data Error", code: 0, userInfo: nil))
//                return
//            }
//            
//            completion(data, nil)
//        }.resume()
    }
    

    func fetchWeather(lat: String, lon: String, completion: @escaping WeatherCompletion) {
        NetRouter<WeatherEndPoint>().request(route: .forecast(lat: lat, lon: lon)) { data, response, error  in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, error)
                return
            }
            
            switch self.handleNetwork(response){
            case .success:
                guard let data else {
                    completion(nil, NetworkResponse.noData)
                    return
                }
                
                self.parseResponse(data: data, responseType: WeatherData.self) { (decodedData: WeatherData?, error) in
                    if let error = error {
                        completion(nil, NetworkResponse.unableToDecode)
                    } else {
                        // Обработка успешно распарсенных данных
                        completion(decodedData, nil)
                    }
                }
                
                
//                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .secondsSince1970
//                do {
//                    let decodeData = try decoder.decode(WeatherData.self, from: data)
//                    completion(decodeData, nil)
//                } catch {
//                    completion(nil, NetworkResponse.unableToDecode)
//                }
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

}

extension NetworkManager {
    func parseResponse<T: Decodable>(data: Data, responseType: T.Type, completion: @escaping (T?, Error?) -> Void) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        do {
            let decodedData = try decoder.decode(responseType, from: data)
            completion(decodedData, nil)
        } catch {
            completion(nil, error)
        }
    }
}
