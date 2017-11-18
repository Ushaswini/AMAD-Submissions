//
//  NotesCell.swift
//  InClass06App
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase

class NotesCell: UITableViewCell {

    @IBOutlet weak var NotesLabel: UILabel!
    
    @IBOutlet weak var DateTimeLabel: UILabel!
    
    var noteDatabaseRef : DatabaseReference!
    
    var currentUserId:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let uid = UserDefaults.standard.string(forKey: "Current_User_Id"){
            currentUserId = uid
        }
        // Initialization code
    }
   
    @IBAction func DeleteNoteBtn(_ sender: UIButton) {
        noteDatabaseRef = Database.database().reference().child(currentUserId).child("Notebooks").child((data?.notebookId)!).child("Notes").child((data?.noteId)!)
        
       noteDatabaseRef.removeValue()
        
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data:Note?{
        didSet{
            UpdateUI()
        }
    }
    func UpdateUI(){
        NotesLabel.text = data?.noteBody
        DateTimeLabel.text = data?.noteCreatedDateTime
    }

}
