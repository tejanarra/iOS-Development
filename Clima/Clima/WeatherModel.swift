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
    
    var icon: String{
        switch id{
        case 200...232: return "cloud.bolt"
        case 300...321: return "cloud.drizzle"
        case 500...531: return "cloud.rain"
        case 600...622: return "cloud.snow"
        case 701...781: return "cloud.fog"
        case 800: return "sun.max"
        case 801...804: return "cloud.bolt"
        default: return "cloud"
        }
    }
}
