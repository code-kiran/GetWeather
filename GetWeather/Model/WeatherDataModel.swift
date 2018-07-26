//
//  WeatherDataModel.swift
//  GetWeather
//
//  Created by kiran on 4/9/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import Foundation
class WeatherDataModel {
    
    //Declare your model variables here
    var temperature: Int = 0
    var condition: Int = 0
    var city: String = "" 
    var weatherIconName: String = ""
    var weatherDescription: String = ""
    
//This method turns a condition code into the name of the weather condition image
    
        func updateWeatherIcon(condition: Int) -> String {
    
        switch (condition) {
    
            case 0...300 :
                return "wind"
    
            case 301...500 :
                return "ModRain"
    
            case 501...600 :
                return "HeavyRain"
    
            case 601...700 :
                return "HeavySnow"
    
            case 701...771 :
                return "Fog"
    
            case 772...799 :
                return "CloudRainThunder"
    
            case 800 :
                return "Sunny"
    
            case 801...804 :
                return "Cloudy"
    
            case 900...903, 905...1000  :
                return "CloudRainThunder"
    
            case 903 :
                return "OccLightThunder"
    
            case 904 :
                return "Sunny"
    
            default :
                return "dunno"
            }
    
        }
}

