//
//  DataStore.swift
//  YaWeather
//
//  Created by Vic on 20.05.2024.
//

import UIKit

class DataStore {
    static let shared = DataStore()
    
    // MARK: - TableView mock data
    var forecast: ForecastResponse?
    
    var dataDaySource: [DayModel] = [
        DayModel(date: "10 Апреля", day: "Вторник"),
        DayModel(date: "11 Апреля", day: "Среда"),
        DayModel(date: "12 Апреля", day: "Черверг"),
        DayModel(date: "13 Апреля", day: "Пятница"),
        DayModel(date: "14 Апреля", day: "Суббота"),
        DayModel(date: "15 Апреля", day: "Воскресенье"),
        DayModel(date: "16 Апреля", day: "Понедельник"),
        DayModel(date: "17 Апреля", day: "Вторник"),
        DayModel(date: "18 Апреля", day: "Среда"),
        DayModel(date: "19 Апреля", day: "Четверг"),
        DayModel(date: "20 Апреля", day: "Пятница"),
        DayModel(date: "21 Апреля", day: "Суббота"),
        DayModel(date: "22 Апреля", day: "Воскресенье"),
        DayModel(date: "23 Апреля", day: "Понедельник"),
        DayModel(date: "24 Апреля", day: "Вторник"),
        DayModel(date: "25 Апреля", day: "Среда")
    ]
    
    // MARK: - Collection view mock data
    var currentConditionsMockData: [CurrentConditionsModel] = [
        CurrentConditionsModel(image: UIImage(systemName: "wind")! ,description: "6 м/с"),
        CurrentConditionsModel(image: UIImage(systemName: "aqi.medium")! ,description: "760 р.ст"),
        CurrentConditionsModel(image: UIImage(systemName: "humidity")! ,description: "66%"),
        CurrentConditionsModel(image: UIImage(systemName: "thermometer.medium")! ,description: "+15°"),
    ]
    
    var hourlyForecastMockData: [NextTwentyFourHoursModel] = [
        NextTwentyFourHoursModel(temperature: "+12°"),
        NextTwentyFourHoursModel(temperature: "+14°"),
        NextTwentyFourHoursModel(temperature: "+13°"),
        NextTwentyFourHoursModel(temperature: "+15°"),
        NextTwentyFourHoursModel(temperature: "+16°"),
        NextTwentyFourHoursModel(temperature: "+13°"),
        NextTwentyFourHoursModel(temperature: "+14°"),
        NextTwentyFourHoursModel(temperature: "+15°"),
        NextTwentyFourHoursModel(temperature: "+17°"),
        NextTwentyFourHoursModel(temperature: "+19°"),
        NextTwentyFourHoursModel(temperature: "+13°"),
        NextTwentyFourHoursModel(temperature: "+15°"),
        NextTwentyFourHoursModel(temperature: "+16°"),
        NextTwentyFourHoursModel(temperature: "+13°"),
        NextTwentyFourHoursModel(temperature: "+14°"),
        NextTwentyFourHoursModel(temperature: "+15°"),
        NextTwentyFourHoursModel(temperature: "+17°"),
        NextTwentyFourHoursModel(temperature: "+19°")
    ]
    
    
    
    
    var pageControlMockData: [UIViewController] = [
        MapViewController()
    ]
    
    private init() {}
}
