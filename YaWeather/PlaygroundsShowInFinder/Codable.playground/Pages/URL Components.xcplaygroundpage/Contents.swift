//: [Previous](@previous)

import Foundation

// MARK: - URL Components example
struct Metar: Decodable, Equatable {
    let icaoId: String
    let rawOb: String
    let name: String
    let rawTaf: String
}

let targetAirport = "URRP"

let currentDate = Date()
let dateFormatter = DateFormatter()
dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
dateFormatter.dateFormat = "yyyyMMdd_HHmmss"

let currentDateForRequest = "\(dateFormatter.string(from: currentDate))Z"

var recievedMetarData: Metar?

func fetchMetarData() {
    // MARK: - transform url into components
    
    // URL component
    var urlComponent = URLComponents()
    // scheme - https
    urlComponent.scheme = "https"
    // host is API host
    urlComponent.host = "aviationweather.gov"
    // path is API engine link
    urlComponent.path = "/api/data/metar"
    
    // gather each option in key: value - String: String to complete request link
    urlComponent.queryItems = [
        URLQueryItem(name: "ids", value: targetAirport),
        URLQueryItem(name: "format", value: "json"),
        URLQueryItem(name: "taf", value: "true"),
        URLQueryItem(name: "hours", value: "5"),
        URLQueryItem(name: "date", value: currentDateForRequest),
    ]
    
    guard let targetURL: URL = urlComponent.url else {
        print("incorrect link created")
        return
    }

    URLSession.shared.dataTask(with: targetURL) { data, _, err in
        if let responseData = data {
            do { // data recieves in two arrays
                let metarArray = try JSONDecoder().decode([Metar].self, from: responseData)
                if let firstMetar = metarArray.first { // creating only one instance of Metar object by model from json
                    recievedMetarData = firstMetar
                    print("Location: \(firstMetar.name)")
                    print("ICAO ID: \(firstMetar.icaoId)")
                    print("METAR: \(firstMetar.rawOb)")
                    print("TAF: \(firstMetar.rawTaf)")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }.resume()
}

fetchMetarData()

//: [Next](@next)
