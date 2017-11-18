//
//  NoteBookCell.swift
//  InClass06App
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit

class NoteBookCell: UITableViewCell {

    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var DateTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data : NoteBook?{
        didSet{
           UpdateUI()
        }
    }
    
    func UpdateUI(){
        NameLabel.text = data?.notebookTitle
        DateTimeLabel.text = data?.notebookDateTime
    }

}
