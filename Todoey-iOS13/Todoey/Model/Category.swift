//
//  Category.swift
//  Todoey
//
//  Created by Teja Narra on 10/25/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit
import RandomColor

class Category: Object{
    @objc dynamic var categoryName:String = ""
    @objc dynamic var dateCreated:Double = Date().timeIntervalSince1970
    @objc dynamic var categoryColor:String = randomColor(luminosity: .bright).hexValue()
    let items = List<Item>()
}
