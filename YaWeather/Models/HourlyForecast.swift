//
//  HourlyForecast.swift
//  YaWeather
//
//  Created by Vic on 26.06.2024.
//

import Foundation

struct ForecastResponse: Codable {
    let forecast: ForecastWrapper
    let current: CurrentInfoResponse
}

struct ForecastWrapper: Codable {
    let forecastday: [ForecastDaily]
}


struct ForecastDaily: Codable {
    let hour: [HourlyForecast]
}

struct HourlyForecast: Codable {
    let time: String
    let temp_c: Double
    let condition: HourlyForecastCondition?
}

struct CurrentInfoResponse: Codable {
    let wind_kph: Double
    let humidity: Int
    let dewpoint_c: Double
    let pressure_mb: Double
}

struct HourlyForecastCondition: Codable {
    let text: HourlyConditionIcons?
    
    // json to enum
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let t = try container.decode(String.self, forKey: .text)
        self.text = HourlyConditionIcons(rawValue: t.trimmingCharacters(in: .whitespaces))
    }
    
    enum CodingKeys: String, CodingKey {
        case text
    }
}

// MARK: - use enum for CodingKey later
