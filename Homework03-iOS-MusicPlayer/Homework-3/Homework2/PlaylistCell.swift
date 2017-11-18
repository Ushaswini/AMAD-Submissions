//
//  PlayListRowCell.swift
//  Homework2
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/18/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import Foundation
import UIKit

class PlaylistCell : UITableViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    var data : Feed?{
        didSet{
            updateUI()
        }
    }
    
    var indexOfThisCell : Int = 0
    
    func updateUI(){
        
        titleLabel.text = data?.title
        authorLabel.text = data?.author
        durationLabel.text = data?.duration
    }
    
    func UpdateUIforSelection(){
        titleLabel.textColor = UIColor(hexString: "#004aa3df")
        authorLabel.textColor = UIColor(hexString: "#004aa3df")
        durationLabel.textColor = UIColor(hexString: "#004aa3df")
    }
    
    func UpdateUIforDeSelection(){
        titleLabel.textColor = UIColor.black
        authorLabel.textColor = UIColor.black
        durationLabel.textColor = UIColor.black
    }
    
    
}
