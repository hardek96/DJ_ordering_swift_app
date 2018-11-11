//
//  DetailViewController.swift
//  DjuP
//
//  Created by Arthur de Kerhor on 17/05/2018.
//  Copyright © 2018 Arthur de Kerhor. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
    @IBOutlet private var photoDJ : UIImageView!
    @IBOutlet private var backButton  : UIButton!
    
    
    @IBOutlet weak var nameDJ: UILabel!
    @IBOutlet weak var styleDJ: UILabel!
    @IBOutlet weak var cityDJ: UILabel!
    @IBOutlet weak var priceDJ: UILabel!
    @IBOutlet weak var descriptionDJ: UITextView!
    @IBOutlet weak var dispoDJ: UITextView!
    
    
    @IBAction func getBack(_ sender : UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    var dj = DJ.shared
    
    enum State{
        case current, next, previous
    }
    
    var photoState : State  = .current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoDJ.isUserInteractionEnabled = true
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragPhotoDJ(_:)))
        photoDJ.addGestureRecognizer(panGestureRecognizer)
        photoDJ.image  = UIImage(named: dj.photoNames[0])
        nameDJ.text = dj.name
        styleDJ.text = dj.style
        cityDJ.text = dj.city
        priceDJ.text = String(dj.price) + " €"
        descriptionDJ.text = dj.description
        dispoDJ.text = dj.dispos
        
    }
    
    @objc func dragPhotoDJ(_ sender: UIPanGestureRecognizer) {
        switch sender.state{
        case .began, .changed :
            transformPhotoDJ(gesture : sender)
        case .ended, .cancelled :
            changePhotoDJ()
        default :
            break
        }
        
    }
    
    private func transformPhotoDJ (gesture : UIPanGestureRecognizer){
        let translation = gesture.translation(in: photoDJ)
        let translationTransform = CGAffineTransform(translationX: translation.x, y: 0)
        photoDJ.transform = translationTransform
        
        if translation.x > 50 {
            self.photoState = .next
        } else if translation.x < -50 {
            self.photoState = .previous
        } else {
            self.photoState = .current
        }
    }
    
    
    private func changePhotoDJ(){
        let screenWidth = UIScreen.main.bounds.width
        var translationTransform: CGAffineTransform
        
        switch photoState {
        case .next:
            translationTransform = CGAffineTransform(translationX: screenWidth, y: 0)
        case .previous:
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
        case .current:
            translationTransform = .identity
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.photoDJ.transform = translationTransform
        }, completion: { (success) in
            if success {
                if self.photoState != .current{
                    self.showNewPhoto()
                    self.photoState = .current
                }
            }
        })
    }
    
   
    private func showNewPhoto(){
        self.photoDJ.transform = .identity
        UIView.animate(withDuration: 1, animations: {
            switch self.photoState {
            case .next : self.photoDJ.image = UIImage(named : self.dj.photoNames[self.dj.getNextPhoto()])
            case .previous : self.photoDJ.image = UIImage(named : self.dj.photoNames[self.dj.getPreviousPhoto()])
            default : break
            }
        })
    }
    
    
}
