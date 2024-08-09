//
//  Weather.swift
//  YaWeather
//
//  Created by Vic on 08.06.2024.
//

import Foundation

struct WeatherData: Codable {
    let nowDate: String //Время сервера в UTC
    let info: Info
    let fact: Fact
    
    enum CodingKeys: String, CodingKey {
        case nowDate = "now_dt"
        case info
        case fact
    }
}

struct Info: Codable {
    let lat: Double
    let lon: Double
}

struct Fact: Codable {
    //    let date: String
    let temp: Int
    let feelsLike: Int
    let icon: String // иконка загружается по адресу
    let condition: Condition?
    let windSpeed: Double
    let pressure: Int
    let humidity: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.feelsLike = try container.decode(Int.self, forKey: .feelsLike)
        self.temp = try container.decode(Int.self, forKey: .temp)
        self.icon = try container.decode(String.self, forKey: .icon)
        self.windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        self.pressure = try container.decode(Int.self, forKey: .pressure)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        if let cond = try? container.decode(String.self, forKey: .condition) {
            self.condition = Condition(rawValue: cond)
        } else {
            self.condition = nil
        }
    }

    
    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case temp
        case icon
        case condition
        case windSpeed = "wind_speed"
        case pressure = "pressure_mm"
        case humidity
    }
}

enum Condition: String, Codable {
    case clear
    case partlyCloudy = "partly-cloudy"
    case cloudy
    case overcast
    case lightRain = "light-rain"
    case rain
    case heavyRain = "heavy-rain"
    case showers
    case wetSnow = "wet-snow"
    case lightSnow = "light-snow"
    case snow
    case snowShowers = "snow-showers"
    case hail
    case thunderstorm
    case thunderstormWithRain = "thunderstorm-with-rain"
    case thunderstormWithHail = "thunderstor-with-hail"
    
    var localizedValue: String {
        switch self {
            
        case .clear:
            return "ясно"
        case .partlyCloudy:
            return "малооблачно"
        case .cloudy:
            return "облачно с прояснениями"
        case .overcast:
            return "пасмурно"
        case .lightRain:
            return "небольшой дождь"
        case .rain:
            return "дождь"
        case .heavyRain:
            return "сильный дождь"
        case .showers:
            return "дожди"
        case .wetSnow:
            return "дождь со снегом"
        case .snowShowers:
            return "снегопад"
        case .lightSnow:
            return "небольшой снег"
        case .hail:
            return "град"
        case .thunderstorm:
            return "град"
        case .thunderstormWithRain:
            return "дождь с грозой"
        case .thunderstormWithHail:
            return "гроза с градом"
        case .snow:
            return "снег"
        }
        
    }
}

enum HourlyConditionIcons: String, Codable {
    case Sunny
    case Clear
    case PartlyCloudy = "Partly cloudy"
    case Cloudy
    case Overcast
    case Mist
    case PatchyRainPossible = "Patchy rain possible"
    case PatchySnowPossible = "Patchy snow possible"
    case PatchySleetPossible = "Patchy sleet possible"
    case PatchyFreezingDrizzlePossible = "Patchy freezing drizzle possible"
    case ThunderyOutbreaksPossible = "Thundery outbreaks possible"
    case BlowingSnow = "Blowing snow"
    case Blizzard
    case Fog
    case FreezingFog = "Freezing fog"
    case PatchyLightDrizzle = "Patchy light drizzle"
    case LightDrizzle = "Light drizzle"
    case FreezingDrizzle = "Freezing drizzle"
    case HeavyFreezingDrizzle = "Heavy freezing drizzle"
    case PatchyLightRain = "Patchy light rain"
    case LightRain = "Light rain"
    case ModerateRainAtTimes = "Moderate rain at times"
    case ModerateRain = "Moderate rain"
    case HeavyRainAtTimes = "Heavy rain at times"
    case HeavyRain = "Heavy rain"
    case LightFreezingRain = "Light freezing rain"
    case ModerateOrHeavyFreezingRain = "Moderate or heavy freezing rain"
    case LightSleet = "Light sleet"
    case ModerateOrHeavySleet = "Moderate or heavy sleet"
    case PatchyLightSnow = "Patchy light snow"
    case LightSnow = "Light snow"
    case PatchyModerateSnow = "Patchy moderate snow"
    case ModerateSnow = "Moderate snow"
    case PatchyHeavySnow = "Patchy heavy snow"
    case HeavySnow = "Heavy snow"
    case IcePellets = "Ice pellets"
    case LightRainShower = "Light rain shower"
    case ModerateOrHeavyRainShower = "Moderate or heavy rain shower"
    case TorrentialRainShower = "Torrential rain shower"
    case LightSleetShowers = "Light sleet showers"
    case ModerateOrHeavySleetShowers = "Moderate or heavy sleet showers"
    case LightSnowShowers = "Light snow showers"
    case ModerateOrHeavySnowShowers = "Moderate or heavy snow showers"
    case LightShowersOfIcePellets = "Light showers of ice pellets"
    case ModerateOrHeavyShowersOfIcePellets = "Moderate or heavy showers of ice pellets"
    case PatchyLightRainWithThunder = "Patchy light rain with thunder"
    case ModerateOrHeavyRainWithThunder = "Moderate or heavy rain with thunder"
    case PatchyLightSnowWithThunder = "Patchy light snow with thunder"
    case ModerateOrHeavySnowWithThunder = "Moderate or heavy snow with thunder"
    
    var localizedValue: String {
        switch self {
        case .Sunny:
            return "sun.max"
        case .Clear:
            return "moon.stars"
        case .PartlyCloudy:
            return "cloud.sun"
        case .Cloudy:
            return "cloud"
        case .Overcast:
            return "icloud.fill"
        case .Mist:
            return "cloud.fog"
        case .PatchyRainPossible:
            return "cloud.drizzle"
        case .PatchySnowPossible:
            return "cloud.snow"
        case .PatchySleetPossible:
            return "cloud.sleet"
        case .PatchyFreezingDrizzlePossible:
            return "cloud.hail"
        case .ThunderyOutbreaksPossible:
            return "cloud.bolt"
        case .BlowingSnow:
            return "cloud.snow.fill"
        case .Blizzard:
            return "snowflake"
        case .Fog:
            return "cloud.fog.fill"
        case .FreezingFog:
            return "cloud.fog.fill"
        case .PatchyLightDrizzle:
            return "cloud.hail.fill"
        case .LightDrizzle:
            return "cloud.drizzle"
        case .FreezingDrizzle:
            return "cloud.sleet"
        case .HeavyFreezingDrizzle:
            return "cloud.sleet.fill"
        case .PatchyLightRain:
            return "cloud.rain"
        case .LightRain:
            return "cloud.rain.fill"
        case .ModerateRainAtTimes:
            return "cloud.rain.fill"
        case .ModerateRain:
            return "scloud.rain.fillun"
        case .HeavyRainAtTimes:
            return "cloud.heavyrain"
        case .HeavyRain:
            return "cloud.heavyrain.fill"
        case .LightFreezingRain:
            return "cloud.sleet"
        case .ModerateOrHeavyFreezingRain:
            return "sun"
        case .LightSleet:
            return "sun"
        case .ModerateOrHeavySleet:
            return "sun"
        case .PatchyLightSnow:
            return "sun"
        case .LightSnow:
            return "sun"
        case .PatchyModerateSnow:
            return "sun"
        case .ModerateSnow:
            return "sun"
        case .PatchyHeavySnow:
            return "sun"
        case .HeavySnow:
            return "sun"
        case .IcePellets:
            return "sun"
        case .LightRainShower:
            return "sun"
        case .ModerateOrHeavyRainShower:
            return "sun"
        case .TorrentialRainShower:
            return "sun"
        case .LightSleetShowers:
            return "sun"
        case .ModerateOrHeavySleetShowers:
            return "sun"
        case .LightSnowShowers:
            return "sun"
        case .ModerateOrHeavySnowShowers:
            return "sun"
        case .LightShowersOfIcePellets:
            return "sun"
        case .ModerateOrHeavyShowersOfIcePellets:
            return "sun"
        case .PatchyLightRainWithThunder:
            return "sun"
        case .ModerateOrHeavyRainWithThunder:
            return "sun"
        case .PatchyLightSnowWithThunder:
            return "sun"
        case .ModerateOrHeavySnowWithThunder:
            return "sun"
        }
    }
}

