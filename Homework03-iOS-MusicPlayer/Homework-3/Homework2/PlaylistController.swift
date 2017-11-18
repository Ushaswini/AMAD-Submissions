//
//  PlaylistController.swift
//  Homework2
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/18/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit
import AVFoundation

class PlaylistController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var playorResumeBtn: UIButton!
    
    private var dataToTable = Array<Feed>()
    
    var TabController : MusicPlayerTabcontroller?{
        get{
            if let parent = self.parent{
                if let parentOfparent = parent.parent{
                    if let tabController = parentOfparent as? MusicPlayerTabcontroller{
                        return tabController
                    }
                }
                
            }
            return nil
        }
    }
    
   
    var CurrentTrack : Feed?{
        get{
            
            return TabController?.currentPlaylistTrack
        }
        set{
            
            TabController?.currentPlaylistTrack = newValue
        }
    }
    
    var PlayListitems : Array<Feed>?{
        get{
            
            return TabController?.playListItems
        }
        set{
            
            TabController?.playListItems = newValue as! [Feed]
        }
    }
    var Player : AVPlayer?{
        get{
            return TabController?.playListPlayer
        }
        set{
            TabController?.playListPlayer = newValue
        }
    }
    
    var IsPlaying : Bool {
        get{
            return (TabController?.isPlaylistPlaying)!
        }set{
            TabController?.isPlaylistPlaying = newValue
        }
    }
    var CurrentIndex : Int {
        get{
            return (TabController?.currentIndex)!
        }set{
            TabController?.currentIndex = newValue
        }
    }
    var IsFeedPlaying : Bool {
        get{
            return (TabController?.isPlaying)!
        }set{
            TabController?.isPlaying = newValue
        }
    }
    
    var FeedPlayer: AVPlayer?{
        get{
            return TabController?.player
        }
        set{
            TabController?.player = newValue
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        slider.setValue(0, animated: true)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.title = "Playlist"
        
        /*prevButton.isHidden = true
        nextButton.isHidden = true
        slider.isHidden = true
        playorResumeBtn.isHidden = true*/

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        dataToTable = PlayListitems ?? Array<Feed>()
        
        tableView.reloadData()
        
        if dataToTable.count == 0 {
            playorResumeBtn.isEnabled = false
        }else{
            playorResumeBtn.isEnabled = true
        }
       
        
        if (IsPlaying){
            playorResumeBtn!.setImage(UIImage(named: "Pause.png"), for: .normal)
        }else{
            playorResumeBtn!.setImage(UIImage(named: "Play.png"), for: .normal)
        }
        
       /* if Player == nil{
            Player = AVPlayer()
        }
        Player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.Player!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.Player!.currentTime());
                self.slider!.value = Float ( time );
            }
        }*/
    }

    

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataToTable.count
    }
   
    @IBAction func previousBtnClicked(_ sender: Any) {
        
        let index = CurrentIndex - 1
        
        if index > 0{
            let newIndexPath = IndexPath(row: CurrentIndex - 1, section:0)
            self.tableView.selectRow(at: newIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
            self.tableView(self.tableView, didSelectRowAt: newIndexPath)
        }
        
        if index == -1
        {
            let newIndexPath = IndexPath(row: (PlayListitems?.count)! - 1, section:0)
            self.tableView.selectRow(at: newIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
            self.tableView(self.tableView, didSelectRowAt: newIndexPath)
        }
       
        //let selectedIndex = tableView.indexPathForSelectedRow?.row ?? 0
        if (!(CurrentIndex <= 0)){
            
            
           // CurrentIndex -= 1
        }
        
    }
   
    @IBAction func PlayOrResumeBtnClicked(_ sender: Any) {
        
        if FeedPlayer != nil{
            if FeedPlayer?.rate == 0{
                
            }else{
                IsFeedPlaying = false
                FeedPlayer?.pause()
            }
        }
        
        if Player != nil{
            if Player?.rate == 0
            {
                Player!.play()
                IsPlaying = true
                playorResumeBtn!.setImage(UIImage(named: "Pause.png"), for: .normal)
                
            } else {
                Player!.pause()
                IsPlaying = false
                playorResumeBtn!.setImage(UIImage(named: "Play.png"), for: .normal)
                
            }
        }else{
            let newIndexPath = IndexPath(row: 0, section:0)
            self.tableView.selectRow(at: newIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
            self.tableView(self.tableView, didSelectRowAt: newIndexPath)
            self.tableView(self.tableView, didDeselectRowAt: IndexPath(row: CurrentIndex, section:0))

        }
        /*if Player == nil{
            let data = dataToTable[0]
            
            CurrentTrack = data
            
            //set current avplayer
            let url = URL(string : (data.mp3Link))
            
            let playerItem = AVPlayerItem(url:url!)
            
            if let player = Player {
                if player.rate == 0{
                    //is not playing
                    
                }else{
                    //is playing
                    player.pause()
                }
            }
            
            CreateAVPlayerandSetSliderProperties(playerItem:playerItem)
        }*/
        
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        
     
       //let selectedIndex = tableView.indexPathForSelectedRow?.row ?? 0
        
        let index = CurrentIndex + 1
        
        if (index < (PlayListitems?.count)!){
            let newIndexPath = IndexPath(row: index, section:0)
            self.tableView.selectRow(at: newIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
            self.tableView(self.tableView, didSelectRowAt: newIndexPath)
            self.tableView(self.tableView, didDeselectRowAt: IndexPath(row: CurrentIndex, section:0))
        }
        
        if index == (PlayListitems?.count)!{
            let newIndexPath = IndexPath(row: 0, section:0)
            self.tableView.selectRow(at: newIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
            self.tableView(self.tableView, didSelectRowAt: newIndexPath)
            self.tableView(self.tableView, didDeselectRowAt: IndexPath(row: CurrentIndex, section:0))
        }
        if (!(CurrentIndex >= (PlayListitems?.count)!)){
            
            //CurrentIndex += 1
        }
       
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        let seconds : Int64 = Int64(slider.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        
        Player!.seek(to: targetTime)
        
        if FeedPlayer != nil{
            if FeedPlayer?.rate == 0{
                
            }else{
                IsFeedPlaying = false
                FeedPlayer?.pause()
            }
        }
        
        IsPlaying = true
        playorResumeBtn.setImage(UIImage(named: "Pause.png"), for: .normal)
        
        if Player!.rate == 0
        {
            Player?.play()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayListCell", for: indexPath) as! PlaylistCell

        // Configure the cell...
        cell.data = dataToTable[indexPath.row]

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? UINavigationController{
            //secondVC.TabController = TabController
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let data = dataToTable[indexPath.row]
        
        CurrentIndex = indexPath.row
        prevButton.isHidden = false
        nextButton.isHidden = false
        slider.isHidden = false
        playorResumeBtn.isHidden = false
        
        if FeedPlayer != nil{
            if FeedPlayer?.rate == 0{
                
            }else{
                IsFeedPlaying = false
                FeedPlayer?.pause()
            }
        }
        
        //set current track
        CurrentTrack = data    
        
        
        //set current avplayer
        let url = URL(string : (data.mp3Link))
        
        let playerItem = AVPlayerItem(url:url!)
        
        if let player = Player {
            if player.rate == 0{
                //is not playing
                
            }else{
                //is playing
                player.pause()
            }
        }
        
        CreateAVPlayerandSetSliderProperties(playerItem:playerItem)
        Player?.play()
        playorResumeBtn.setImage(UIImage(named: "Pause.png"), for: .normal)
        IsPlaying = true
        //let cell = tableView.cellForRow(at: indexPath) as! PlaylistCell
        //cell.UpdateUIforSelection()
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //let cell = tableView.cellForRow(at: indexPath) as! PlaylistCell
        //cell.UpdateUIforDeSelection()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            
            if CurrentTrack?.mp3Link == PlayListitems![indexPath.row].mp3Link{
                CurrentTrack = nil
                Player?.pause()
                playorResumeBtn!.setImage(UIImage(named: "Play.png"), for: .normal)
                slider.setValue(0, animated: true)
                IsPlaying = false
            }
            // remove the item from the data model
            PlayListitems?.remove(at: indexPath.row)
            dataToTable.remove(at: indexPath.row)
            
            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
    }
    
    
   
    @IBAction func unwindToController(segue: UIStoryboardSegue) {
        
    }
    
    func CreateAVPlayerandSetSliderProperties(playerItem : AVPlayerItem){
        
        Player = AVPlayer(playerItem:playerItem)
        
        Player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.Player!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.Player!.currentTime());
                self.slider!.value = Float ( time );
            }
        }
        
        NotificationCenter.default.addObserver(self,selector: #selector(PlaylistController.playerDidFinishPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        slider!.minimumValue = 0
        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        slider!.maximumValue = Float(seconds)
        slider!.isContinuous = false
    }
    
    @objc func playerDidFinishPlaying(_ myNotification:NSNotification){
        
        //let selectedIndex = tableView.indexPathForSelectedRow?.row ?? 0
        var newIndexPath:IndexPath = IndexPath(row: 0, section:0)
        
        let size = (PlayListitems?.count)! - 1
        
        if (!(CurrentIndex >= size)){
            newIndexPath = IndexPath(row: CurrentIndex + 1, section:0)
        }
        if (CurrentIndex == size){
            newIndexPath = IndexPath(row: 0, section:0)
        }
        
        self.tableView.selectRow(at: newIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
        self.tableView(self.tableView, didSelectRowAt: newIndexPath)
        self.tableView(self.tableView, didDeselectRowAt: IndexPath(row: CurrentIndex, section:0))
       
    }

}
