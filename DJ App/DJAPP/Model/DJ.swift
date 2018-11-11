//
//  DJ.swift
//  DjuP
//
//  Created by Arthur de Kerhor on 16/05/2018.
//  Copyright © 2018 Arthur de Kerhor. All rights reserved.
//

import Foundation

struct DJ {
    let name : String
    let price : Int
    let photoNames : [String]
    let style : String
    let city : String
    let stars : String
    let comments : Int
    let dispos : String
    let description : String
    var IndexOfPhoto : Int 
    
    static var shared = DJ(name : "DJ Name", price : 0, photoNames : ["photo du DJ"], style : "Tous les styles", city : "Paris", stars : "5stars_rating", comments : 0, dispos : "dispos DJ", description : "description", IndexOfPhoto : 0 )
    
    mutating func getNextPhoto () -> Int {
        if IndexOfPhoto == photoNames.count - 1{
            IndexOfPhoto = 0
        } else {
            IndexOfPhoto += 1
        }
        return IndexOfPhoto
    }
    
    mutating func getPreviousPhoto () -> Int {
        if IndexOfPhoto == 0{
            IndexOfPhoto = photoNames.count - 1
        } else {
            IndexOfPhoto -= 1
        }
        return IndexOfPhoto
    }
    
}
