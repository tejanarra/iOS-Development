//
//  Category.swift
//  Todoey
//
//  Created by Teja Narra on 10/25/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var categoryName:String = ""
    @objc dynamic var dateCreated:Double = Date().timeIntervalSince1970
    let items = List<Item>()
}
