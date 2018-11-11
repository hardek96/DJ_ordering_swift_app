//
//  DateViewController.swift
//  DjuP
//
//  Created by Arthur de Kerhor on 09/05/2018.
//  Copyright © 2018 Arthur de Kerhor. All rights reserved.
//

import UIKit

class DateViewController : UIViewController {
    
    @IBOutlet weak private var dateTitle: UILabel!
    @IBOutlet weak private var datePicker: UIDatePicker!
    @IBOutlet weak private var durationTitle: UILabel!
    @IBOutlet weak private var durationPicker: UIDatePicker!
    @IBOutlet weak private var registerButton: UIButton!
    
    var filter = Filter.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date()
        datePicker.date = filter.date
        durationPicker.countDownDuration = filter.duration
    }
    
    @IBAction func dateDidChanged(_ sender: UIDatePicker) {
        filter.date = sender.date
    }
    
    @IBAction func durationDidChanged(_ sender: UIDatePicker) {
        filter.duration = sender.countDownDuration
    }
    
    @IBAction private func register() {
        dismiss(animated : true, completion : nil)
    }
    
    
   
    
}

