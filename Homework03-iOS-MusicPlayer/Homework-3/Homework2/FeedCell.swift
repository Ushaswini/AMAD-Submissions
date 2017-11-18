//
//  FeedCell.swift
//  Homework2
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/22/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
     var delegate:FeedCellDelegator!

    @IBAction func playOrPause(_ sender: Any) {
        isPlaying = !isPlaying
        delegate.playOrPausePlayer(index: indexOfThisCell, play : isPlaying)
    }
    
   
    @IBAction func playOrPauesFeed(_ sender: Any) {
       if(self.delegate != nil){
        delegate.playOrPausePlayer(index: indexOfThisCell, play : isPlaying)
        }
    }
    @IBOutlet weak var playOrPauseBtn: UIButton!
    
    @IBOutlet weak var playListBtn: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var isPlaying : Bool = false
    
    @IBAction func playMusicBtn(_ sender: UIButton) {
        if(self.delegate != nil){ //Just to be safe.
            self.delegate.addToOrRemoveFromPlaylist(index:indexOfThisCell)
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var data : Feed?{
        didSet{
            updateUI()
        }
    }
    
    var indexOfThisCell : Int = 0
    
    func updateUI(){
        
        titleLabel.text = data?.title
        authorLabel.text = data?.author
        descriptionLabel.text = data?.duration
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func UpdateUIforSelection(){
        titleLabel.textColor = UIColor(hexString: "#004aa3df")
        authorLabel.textColor = UIColor(hexString: "#004aa3df")
        descriptionLabel.textColor = UIColor(hexString: "#004aa3df")
    }
    
    func UpdateUIforDeSelection(){
        titleLabel.textColor = UIColor.black
        authorLabel.textColor = UIColor.black
        descriptionLabel.textColor = UIColor.black
    }

}
