//
//  DJCellView.swift
//  DjuP
//
//  Created by Arthur de Kerhor on 16/05/2018.
//  Copyright © 2018 Arthur de Kerhor. All rights reserved.
//

import UIKit

class DJCellView : UITableViewCell {
    @IBOutlet private var photo : UIImageView!
    @IBOutlet private var name : UILabel!
    @IBOutlet private var style : UILabel!
    @IBOutlet private var stars : UIImageView!
    @IBOutlet private var numberComments : UILabel!
    
    func updateCell(with dj : DJ){
        photo.image = UIImage(named : dj.photoNames[0])
        name.text = dj.name + " " + String(dj.price) + "€"
        style.text = dj.style
        numberComments.text = String(dj.comments) + " commentaires"
        stars.image = UIImage(named : dj.stars)
    }
    
    
}
