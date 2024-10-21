//
//  WeatherData.swift
//  Clima
//
//  Created by Teja Narra on 10/19/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable{
    let name : String
    let main : Main
    let weather: [Weather]
}

struct Main: Codable{
    let temp : Double
    let feels_like : Double
    let humidity : Int
}

struct Weather: Codable{
    let main : String
    let description : String
    let id: Int
}
