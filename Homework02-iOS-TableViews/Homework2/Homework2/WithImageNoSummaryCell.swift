//
//  WithImageNoSummaryCell.swift
//  Homework2
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/6/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit

class WithImageNoSummaryCell: UITableViewCell {
    
    
    @IBOutlet weak var photoView: UIImageView!    

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var developerNameLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var otherPhotoView: UIImageView!
    
    var data : RowCell? {
        didSet{
            UpdateUI()
        }
    }
    func UpdateUI(){
        
        developerNameLabel.text = data?.artist
        titleLabel.text = data?.name
        releaseDateLabel.text = data?.releaseDate
        costLabel.text = "$ \(data?.price ?? 0.0)"
        let imageUrl:URL? = URL(string: (data?.squareImage)!)
        photoView.sd_setImage(with: imageUrl)
        let otherImageUrl:URL? = URL(string: (data?.otherImage)!)
        otherPhotoView.sd_setImage(with: otherImageUrl)
    }
}
