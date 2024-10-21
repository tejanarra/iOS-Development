//
//  WeatherModel.swift
//  Clima
//
//  Created by Teja Narra on 10/19/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation


struct WeatherModel{
    let temperature: Double
    let id: Int
    let city: String
    
    var temperatureString : String{
        return String(format: "%.1f", temperature)
    }
    
    var icon: String {
        switch id {
        case 200...232: return "cloud.bolt" // Thunderstorm
        case 300...321: return "cloud.drizzle" // Drizzle
        case 500...511: return "cloud.rain" // Light to moderate rain
        case 512...531: return "cloud.heavyrain" // Heavy rain
        case 600...622: return "cloud.snow" // Snow
        case 701...781: return "cloud.fog" // Fog
        case 800: return "sun.max" // Clear sky
        case 801: return "cloud.sun" // Few clouds
        case 802: return "cloud.sun.rain" // Scattered clouds
        case 803: return "cloud" // Broken clouds
        case 804: return "cloud.fill" // Overcast clouds
        case 900: return "tornado" // Tornado
        case 901: return "hurricane" // Tropical storm
        case 902: return "snow" // Severe cold
        case 903: return "snowflake" // Extreme cold
        case 904: return "sun.max.fill" // Hot
        case 905: return "wind" // Windy
        case 906: return "cloud.hail" // Hail
        case 951: return "sunrise" // Calm
        case 952: return "wind" // Light breeze
        case 953: return "cloud" // Moderate breeze
        case 954: return "cloud" // Fresh breeze
        case 955: return "cloud.fill" // Strong breeze
        default: return "cloud" // Default fallback
        }
    }


}
