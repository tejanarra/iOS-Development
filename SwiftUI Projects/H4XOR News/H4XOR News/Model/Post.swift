//
//  Post.swift
//  H4XOR News
//
//  Created by Teja Narra on 10/23/24.
//

import Foundation

struct Post: Decodable{
    let hits: [News]
}

struct News: Decodable,Identifiable{
    var id: String{
        return objectID
    }
    let title: String
    let url: String?
    let objectID: String
    let points: Int
}


