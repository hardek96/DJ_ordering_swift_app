//
//  Filter.swift
//  DjuP
//
//  Created by Arthur de Kerhor on 10/05/2018.
//  Copyright © 2018 Arthur de Kerhor. All rights reserved.
//

import Foundation
class Filter {
    var numberOfPeopleRow = 0
    var numberOfPeople = "0-20 personnes"
    var date = Date()
    var duration : TimeInterval = 0
    var location = "Où ?"
    var Style : [String : Bool]
    var styleString = "Tous les styles"
    var NeedASpeaker = false
    
    static let shared = Filter()
    private init() {
        Style = ["Tous" : false, "Dance" : false, "Deep House" : false, "Drum & Bass" : false, "Dubstep" :false, "Electro House" : false, "Future House" : false, "Minimale" : false, "Progressive House" : false, "Tech House" : false, "Techno" :  false, "Trance" : false, "Trap" : false]
    }
}

