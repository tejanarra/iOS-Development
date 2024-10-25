//
//  CustomCategoryCell.swift
//  Todoey
//
//  Created by Teja Narra on 10/25/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit

class CustomCategoryCell: UITableViewCell {
    
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var name: UILabel!
    @objc dynamic var dateCreated:Double = Date().timeIntervalSince1970
}
