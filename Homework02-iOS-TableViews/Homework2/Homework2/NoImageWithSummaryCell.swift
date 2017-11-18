//
//  NoImageWithSummaryCell.swift
//  Homework2
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/6/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit

class NoImageWithSummaryCell: UITableViewCell {
  
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var developerLabel: UILabel!
    
    var data : RowCell? {
        didSet{
            UpdateUI()
        }
    }
    func UpdateUI(){
        
        developerLabel.text = data?.artist
        titleLabel.text = data?.name
        releaseDateLabel.text = data?.releaseDate
        costLabel.text = "$ \(data?.price ?? 0.0)"
        let imageUrl:URL? = URL(string: (data?.squareImage)!)
        photoView.sd_setImage(with: imageUrl)
        summaryLabel.text = data?.summary
    }
}
