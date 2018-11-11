//
//  NumberViewController.swift
//  DjuP
//
//  Created by Arthur de Kerhor on 09/05/2018.
//  Copyright © 2018 Arthur de Kerhor. All rights reserved.
//

import UIKit

class NumberViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak private var numberTitle: UILabel!
    @IBOutlet weak private var numberPicker: UIPickerView!
    @IBOutlet weak private var speakerTitle: UILabel!
    @IBOutlet weak private var speakerSwitch: UISwitch!
    @IBOutlet weak private var registerButton: UIButton!
   
    var filter = Filter.shared
    private var pickerData = ["0-20", "20-50", "50-80", "80-100", "+ de 100"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.numberPicker.delegate = self
        self.numberPicker.dataSource = self
        speakerSwitch.isOn = filter.NeedASpeaker
        numberPicker.selectRow(filter.numberOfPeopleRow, inComponent:0, animated : true)
    
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    @IBAction func switchDidChange(_ sender: UISwitch) {
        filter.NeedASpeaker = speakerSwitch.isOn
    }
    
    @IBAction private func register() {
        filter.numberOfPeopleRow = numberPicker.selectedRow(inComponent: 0)
        filter.numberOfPeople = pickerData[filter.numberOfPeopleRow] + " personnes"
        dismiss(animated : true, completion : nil)
    }
    
}

