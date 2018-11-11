//
//  ResearchBoard.swift
//  DjuP
//
//  Created by Arthur de Kerhor on 13/05/2018.
//  Copyright © 2018 Arthur de Kerhor. All rights reserved.
//

import UIKit


class ResearchBoard : UIView {
    @IBOutlet private var locationButton: UIButton!
    @IBOutlet private var dateButton: UIButton!
    @IBOutlet private var styleButton: UIButton!
    @IBOutlet private var collapseButton: UIButton!
    @IBOutlet private var numberButton: UIButton!
    @IBOutlet private var summaryFilter: UIButton!
    let filter = Filter.shared
    
    enum State{
        case normal, reduced
    }
    
    let headerInputHeight: CGFloat = 40
    
    var minHeaderHeight: CGFloat {
        return 20 // status bar
    }
    
    var midHeaderHeight: CGFloat {
        return 20 + 10 // status bar + spacing
            + headerInputHeight + 10 // input 1 +spacing
        
    }
    var maxHeaderHeight: CGFloat {
        return 20 + 10 // status bar + spacing
            + 40 + 10 // collapse button + spacing
            + 40 + 10 // input 1 + spacing
            + 40 + 10 // input 2 + spacing
            + 40 + 10 // input 3 + spacing
            + 40 + 10 // input 4 +spacing
            + 10 //finalspacing
    }
    
    let collapseButtonHeight: CGFloat = 40
    let collapseButtonMaxTopSpacing: CGFloat = 20 + 10
    let collapseButtonMinTopSpacing: CGFloat = 0
    
    @IBOutlet private var collapseButtonTopConstraint: NSLayoutConstraint?
    @IBOutlet private var locationButtonTopConstraint: NSLayoutConstraint?
    
    
    public func updateHeader(newHeight: CGFloat, offset: CGFloat) {
        let headerBottom = newHeight
        
        let midMaxPercentage = (newHeight - midHeaderHeight) / (maxHeaderHeight - midHeaderHeight)
        dateButton.alpha = midMaxPercentage
        
        var stylePercentage = (headerBottom - styleButton.frame.origin.y) / (styleButton.frame.height + numberButton.frame.height + 20)
        stylePercentage = max(0, min(1, stylePercentage)) // capped between 0 and 1
        styleButton.alpha = stylePercentage
        
        var numberPercentage = (headerBottom - numberButton.frame.origin.y) / numberButton.frame.height
        numberPercentage = max(0, min(1, numberPercentage)) // capped between 0 and 1
        numberButton.alpha = numberPercentage
        
        collapseButton.alpha = numberPercentage
        
        var collapseButtonTopSpacingPercentage = (headerBottom - locationButton.frame.origin.y) / (numberButton.frame.origin.y + numberButton.frame.height - locationButton.frame.origin.y)
        collapseButtonTopSpacingPercentage = max(0, min(1, collapseButtonTopSpacingPercentage))
        collapseButtonTopConstraint?.constant = collapseButtonTopSpacingPercentage * collapseButtonMaxTopSpacing
        
        summaryFilter.setTitle("\(locationButton.titleLabel!.text!) • \(dateButton.titleLabel!.text!) • \(numberButton.titleLabel!.text!)", for: .normal)
        
        if newHeight > midHeaderHeight {
            locationButton.alpha = collapseButtonTopSpacingPercentage
            locationButtonTopConstraint?.constant = max(UIApplication.shared.statusBarFrame.height + 10,collapseButtonTopSpacingPercentage * (collapseButtonHeight + collapseButtonMaxTopSpacing + 10))
            summaryFilter.alpha = 1 - collapseButtonTopSpacingPercentage
            
            
            
            
        } else if newHeight == midHeaderHeight {
            locationButtonTopConstraint?.constant = UIApplication.shared.statusBarFrame.height + 10
            locationButton.alpha = 0
            summaryFilter.alpha = 1
            
            
        } else {
            locationButtonTopConstraint?.constant = locationButtonTopConstraint!.constant - offset
            let minMidPercentage = (newHeight - minHeaderHeight) / (midHeaderHeight - minHeaderHeight)
            locationButton.alpha = 0
            summaryFilter.alpha = minMidPercentage
            
        }
    }
    
}


