//
//  Weather.swift
//  cis357hw3
//
//  Created by Workbook on 11/29/18.
//  Copyright © 2018 Workbook. All rights reserved.
//

import Foundation
//    HW#11
struct Weather {
    var iconName : String
    var temperature : Double
    var summary : String
    
    init(iconName: String, temperature: Double, summary: String) {
        self.iconName = iconName
        self.temperature = temperature
        self.summary = summary
    }
}

protocol WeatherService {
    func getWeatherForDate(date: Date, forLocation location: (Double, Double),
                           completion: @escaping (Weather?) -> Void)
}
