//
//  DarkSkyWeatherService.swift
//  cis357hw3
//
//  Created by Workbook on 11/29/18.
//  Copyright © 2018 Workbook. All rights reserved.
//

import Foundation

let sharedDarkSkyInstance = DarkSkyWeatherService()

class DarkSkyWeatherService: WeatherService {
    
    let API_BASE = "https://api.darksky.net/forecast/"
    var urlSession = URLSession.shared
    
    class func getInstance() -> DarkSkyWeatherService {
        return sharedDarkSkyInstance
    }
    
    func getWeatherForDate(date: Date, forLocation location: (Double, Double),
                           completion: @escaping (Weather?) -> Void)
    {
        
        // HW#11
        let urlStr = API_BASE +  "8005a5a0d3fc32d5fe715a2668126b69" + "/\(location.0),\(location.1),\(Int(date.timeIntervalSince1970))"
        let url = URL(string: urlStr)
        
        let task = self.urlSession.dataTask(with: url!) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let _ = response {
                let parsedObj : Dictionary<String,AnyObject>!
                do {
                    parsedObj = try JSONSerialization.jsonObject(with: data!, options:
                        .allowFragments) as? Dictionary<String,AnyObject>
                    
                    //                    HW#11
                    guard let currently = parsedObj["currently"],
                        let summary = currently["summary"] as? String,
                        let iconName = currently["icon"] as? String,
                        let temperature = currently["temperature"] as? Double
                    
                    
                    else {
                        completion(nil)
                        return
                    }
                    
                    let weather = Weather(iconName: iconName, temperature: temperature,
                                          summary: summary)
                    completion(weather)
                    
                }  catch {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
}
