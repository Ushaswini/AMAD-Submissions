//
//  PlayTrackController.swift
//  Homework2
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/19/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit
import AVFoundation

class PlayTrackController: UIViewController{
    
    var delegate:ControllerDelegate!
    
    var player : AVPlayer?
    
    var playerItem : AVPlayerItem?
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        
        let seconds : Int64 = Int64(slider.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        
        player?.seek(to: targetTime)
        
        if player?.rate == 0
        {
            player?.play()
            delegate.UpdatePlayingStatus(isPlaying: true)
        }
        playOrResumeBtn.setImage(UIImage(named: "Pause.png"), for: .normal)
        delegate.UpdatePlayer(player: player!)
        delegate.UpdateCurrentTrack(feed: FullListitems[Index])
        
    }
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var descritionLabel: UILabel!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playOrResumeBtn: UIButton!
    
  
    var FullListitems = Array<Feed>()
    
    var PlayListItems = Array<Feed>()
    
    var Index :Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        UpdateDisplay()
       
    }


    @IBAction func PlayOrResume(_ sender: Any) {
        
        delegate.UpdateCurrentTrack(feed: FullListitems[Index])
        delegate.UpdatePlayer(player: player!)
        
        
        if player?.rate == 0
        {
            player!.play()
            delegate.UpdatePlayingStatus(isPlaying: true)
            playOrResumeBtn!.setImage(UIImage(named: "Pause.png"), for: .normal)
            
        } else {
            player!.pause()
            delegate.UpdatePlayingStatus(isPlaying: false)
            playOrResumeBtn!.setImage(UIImage(named: "Play.png"), for: .normal)
            
        }
    }
    
    @IBAction func ShowMenu(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Options", message: "", preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let current = FullListitems[Index]
        var title = ""
        var isInPlaylistAlready : Bool
        var indexOfPlaylistItem = 1
        
        for task in PlayListItems {
            if current.mp3Link == task.mp3Link {
                break
            }
            indexOfPlaylistItem += 1
        }
        
        if indexOfPlaylistItem > PlayListItems.count || PlayListItems.count == 0 {
            //not in list add to list
            title = "Add to playlist"
            isInPlaylistAlready = false
        }else{
            title = "Remove from playlist"
            isInPlaylistAlready = true
        }
        
        alertController.addAction(UIAlertAction(title: title, style: UIAlertActionStyle.default)
        { action -> Void in
            //if isInPlaylistAlready{
                self.delegate.addToOrRemoveFromPlaylist(index: self.Index)
           // }
            
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default)
        { action -> Void in
            // Put your code here
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func PlayNext(_ sender: Any) {
        
        var index = 0
        let CurrentTrack = FullListitems[Index]
        for task in (FullListitems) {
            if task.mp3Link == CurrentTrack.mp3Link {
                break
            }
            index += 1
            
        }
        
        if(index < (FullListitems.count) - 1){
            index += 1
            Index = index
            
        }
        if (index == FullListitems.count - 1){
            index = 0
            Index = index
        }
       
        if player?.rate == 0
        {
                
                
        } else {
            player!.pause()
            delegate.UpdatePlayingStatus(isPlaying: false)
            playOrResumeBtn!.setImage(UIImage(named: "Play.png"), for: .normal)
                
        }
        UpdateDisplay()
        
    }
    @IBAction func PlayPrevious(_ sender: Any) {
        
        var index = 0
        let CurrentTrack = FullListitems[Index]
        
        for task in (FullListitems) {
            if task.mp3Link == CurrentTrack.mp3Link {
                break
            }
            index += 1
            
        }
        
        if(index > 0){
            index -= 1
            Index = index
            
        }
        if (index == 0){
            index = FullListitems.count - 1
            Index = index
        }
        
        if player?.rate == 0
        {
                
                
        } else {
            player!.pause()
            delegate.UpdatePlayingStatus(isPlaying: false)
            playOrResumeBtn!.setImage(UIImage(named: "Play.png"), for: .normal)
                
        }
        UpdateDisplay()
        
    }
    
    func UpdateDisplay(){        
        
        let current = FullListitems[Index]
        slider.setValue(0, animated: true)
        
        self.title = current.title
        
        titleLabel.text = "Title: " + current.title
        authorLabel.text = "Author: " + current.author
        pubDateLabel.text = "Duration: " + current.duration
        descritionLabel.text = "Description: " + current.subtitle
        
        let url = URL(string : (current.mp3Link))
        let playerItem:AVPlayerItem = AVPlayerItem(url:url!)
        
        player = AVPlayer(playerItem:playerItem)
        player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player?.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds((self.player?.currentTime())!);
                self.slider!.value = Float ( time );
            }
        }
        
        NotificationCenter.default.addObserver(self,selector: #selector(PlaylistController.playerDidFinishPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        slider!.minimumValue = 0
        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        slider!.maximumValue = Float(seconds)
        slider!.isContinuous = false
        
        playOrResumeBtn!.setImage(UIImage(named: "Play.png"), for: .normal)
    }
    
    @objc func playerDidFinishPlaying(_ myNotification:NSNotification){
        
        
        
        playOrResumeBtn!.setImage(UIImage(named: "Play.png"), for: .normal)
        delegate.UpdatePlayingStatus(isPlaying: false)
       
        
    }
    
    func CreateAVPlayerandSetSliderProperties(playerItem : AVPlayerItem){
        
        player = AVPlayer(playerItem:playerItem)
        
        
        
        NotificationCenter.default.addObserver(self,selector: #selector(PlaylistController.playerDidFinishPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        slider!.minimumValue = 0
        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        slider!.maximumValue = Float(seconds)
        slider!.isContinuous = false
    }
    
   
}
