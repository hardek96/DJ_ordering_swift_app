//
//  StyleViewController.swift
//  DjuP
//
//  Created by Arthur de Kerhor on 09/05/2018.
//  Copyright © 2018 Arthur de Kerhor. All rights reserved.
//

import UIKit

class StyleViewController: UIViewController {
    
    @IBOutlet weak private var styleTitle: UILabel!
    @IBOutlet weak private var registerButton: UIButton!
    @IBOutlet weak var casesStackView: UIStackView!
    @IBOutlet weak var stylesStackView: UIStackView!
    
    var filter = Filter.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var button : UIButton
        var label : UILabel
        for i in 0...casesStackView.arrangedSubviews.count-1{
            button = casesStackView.arrangedSubviews[i] as! UIButton
            label = stylesStackView.arrangedSubviews[i] as! UILabel
            if filter.Style[label.text!]! {
                button.setImage(UIImage(named: "case_et_check"), for: .normal)
            } else {
                button.setImage(UIImage(named: "case"), for: .normal)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func everyStyle(_ sender: UIButton) {
        var button : UIButton
        var label : UILabel
        if(filter.Style["Tous"]!){
            for i in 0...casesStackView.arrangedSubviews.count-1{
                button = casesStackView.arrangedSubviews[i] as! UIButton
                label = stylesStackView.arrangedSubviews[i] as! UILabel
                filter.Style[label.text!] = false
                UIView.animate(withDuration: 0.2, animations: {
                    button.setImage(UIImage(named: "case"), for: .normal)
                })
            }
        } else {
            for i in 0...casesStackView.arrangedSubviews.count-1{
                button = casesStackView.arrangedSubviews[i] as! UIButton
                label = stylesStackView.arrangedSubviews[i] as! UILabel
                filter.Style[label.text!] = true
                UIView.animate(withDuration: 0.2, animations: {
                    button.setImage(UIImage(named: "case_et_check"), for: .normal)
                })
            }
        }
    }
    
    
    @IBAction func styleDidChange(_ sender : UIButton){
        if let index = casesStackView.arrangedSubviews.index(of: sender){
            let label = stylesStackView.arrangedSubviews[index] as! UILabel
            if filter.Style[label.text!]! {
                filter.Style[label.text!] = false
                UIView.animate(withDuration: 0.2, animations: {
                    sender.setImage(UIImage(named: "case"), for: .normal)
                })
            } else {
                filter.Style[label.text!] = true
                UIView.animate(withDuration: 0.2, animations: {
                    sender.setImage(UIImage(named: "case_et_check"), for: .normal)
                })
            }
        }
    }
    
    @IBAction private func register() {
        dismiss(animated : true, completion : nil)
    }
    
    
    
}

