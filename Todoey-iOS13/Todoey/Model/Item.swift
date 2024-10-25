//
//  Item.swift
//  Todoey
//
//  Created by Teja Narra on 10/25/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var itemName:String = ""
    @objc dynamic var isCompleted:Bool = false
    @objc dynamic var dateCreated:Double = Date().timeIntervalSince1970
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
