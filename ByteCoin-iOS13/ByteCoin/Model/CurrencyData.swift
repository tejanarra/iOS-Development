//
//  CurrencyData.swift
//  ByteCoin
//
//  Created by Teja Narra on 10/21/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct CurrencyData: Codable{
    let rate: Double
    let asset_id_quote: String
    let asset_id_base: String
}
