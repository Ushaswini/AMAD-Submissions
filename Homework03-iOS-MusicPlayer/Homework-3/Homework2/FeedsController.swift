//
//  FeedsController.swift
//  Homework2
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/21/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit
import AVFoundation

class FeedsController: UIViewController,XMLParserDelegate,UITableViewDataSource,FeedCellDelegator,UITableViewDelegate,ControllerDelegate {
    
    
    func playOrPausePlayer(index: Int,play:Bool) {
        
        if CurrentTrack?.mp3Link == feeds[index].mp3Link{
            //same as current track playing..
            if let player = Player {
                if player.rate == 0{
                    //is not playing
                    player.play()
                    IsPlaying = true
                }else{
                    //is playing
                    player.pause()
                    IsPlaying = false
                }
            }
        }else{
            
            if PlaylistPlayer != nil{
                if PlaylistPlayer?.rate == 0{
                    
                }else{
                    IsPlaylistPlaying = false
                    PlaylistPlayer?.pause()
                }
            }
            let data = feeds[index]
            //set current track
            CurrentTrack = data
            
            currentTrackLabel.text = data.title
            
            //set current avplayer
            let url = URL(string : (data.mp3Link))
            let playerItem:AVPlayerItem = AVPlayerItem(url:url!)
            //update current player
            Player = AVPlayer(playerItem:playerItem)
            
            if let player = Player {
                if player.rate == 0{
                    //is not playing
                    player.play()
                    
                }else{
                    //is playing
                    player.pause()
                }
            }
            IsPlaying = true
            
            currentTrackplayBtn.setImage(UIImage(named: "Pause.png"), for: .normal)
        }
        
        currentTrackplayBtn.isHidden = false
        currentTrackplayBtn.isEnabled = true
        
        let indexPath = IndexPath(row:index,section:0)
        let cell = tableView.cellForRow(at: indexPath) as! FeedCell
        
        if IsPlaying{
            cell.playOrPauseBtn.setImage(UIImage(named: "Pause.png"), for: .normal)
            currentTrackplayBtn.setImage(UIImage(named: "Pause.png"), for: .normal)
        }else{
            cell.playOrPauseBtn.setImage(UIImage(named: "Play.png"), for: .normal)
            currentTrackplayBtn.setImage(UIImage(named: "Play.png"), for: .normal)
        }
        
        
        
        
        
        //UPDATE CELL STATUS AS WELL
        
       
    }
    
    func UpdatePlayer(player: AVPlayer) {
        Player = player
    }
    
    
    func UpdatePlayingStatus(isPlaying: Bool) {
        
        IsPlaying = isPlaying
        
        if PlaylistPlayer != nil{
            if PlaylistPlayer?.rate == 0{
                
            }else{
                IsPlaylistPlaying = false
                PlaylistPlayer?.pause()
            }
        }
        
        if let index = feeds.index(of:CurrentTrack!){
            let indexPath = IndexPath(row:index,section:0)
            let cell = tableView.cellForRow(at: indexPath) as! FeedCell
            if isPlaying{
                cell.playOrPauseBtn.setImage(UIImage(named: "Pause.png"), for: .normal)
            }else{
                cell.playOrPauseBtn.setImage(UIImage(named: "Play.png"), for: .normal)
            }
        }
        
        if isPlaying{
          currentTrackplayBtn.setImage(UIImage(named: "Pause.png"), for: .normal)
        }else{
            currentTrackplayBtn.setImage(UIImage(named: "Play.png"), for: .normal)
        }
        
    }
    
   
    
   
    func UpdateCurrentTrack(feed: Feed) {
        CurrentTrack = feed
    }
    
   
    
    @IBOutlet weak var currentTrackLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let UrlToDownloadFeeds = "http://feed.thisamericanlife.org/talpodcast"
    
    @IBOutlet weak var currentTrackplayBtn: UIButton!
    
    var feedTitle = ""
    var feedSubTitle = ""
    var feedDescription = ""
    var feedPubDate = ""
    var feedMp3Link = ""
    var feedAuthor = ""
    var feedDuration = ""
    
    var eName = ""
    var feeds = Array<Feed>()
    var feed = Feed()
    var isItemTag = false
    
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
            
            return TabController?.currentTrack
        }
        set{
            
            TabController?.currentTrack = newValue
        }
    }
    
    var Player : AVPlayer?{
        get{
            return TabController?.player
        }
        set{
            TabController?.player = newValue
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
    
    var IsPlaying : Bool {
        get{
            return (TabController?.isPlaying)!
        }set{
            TabController?.isPlaying = newValue
        }
    }
    
    var IsPlaylistPlaying : Bool {
        get{
            return (TabController?.isPlaylistPlaying)!
        }set{
            TabController?.isPlaylistPlaying = newValue
        }
    }
    var PlaylistPlayer : AVPlayer?{
        get{
            return TabController?.playListPlayer
        }
        set{
            TabController?.playListPlayer = newValue
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let path = URL(string:UrlToDownloadFeeds)!
        
        if let parser = XMLParser(contentsOf: path){
            parser.delegate = self
            parser.parse()
        }
        
       
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let currentTrack = CurrentTrack {
            
            currentTrackLabel.text = currentTrack.title
            currentTrackplayBtn.isEnabled = true
            currentTrackplayBtn.isHidden = false
            
            if (IsPlaying){
                currentTrackplayBtn!.setImage(UIImage(named: "Pause.png"), for: .normal)
            }else{
                 currentTrackplayBtn!.setImage(UIImage(named: "Play.png"), for: .normal)
            }
        }
        else{
 
            currentTrackplayBtn.isEnabled = false
            currentTrackplayBtn.isHidden = true
            currentTrackLabel.text = ""
       }
        tableView.reloadData()
    }
    @IBAction func playTrack(_ sender: Any) {
        
        if PlaylistPlayer != nil{
            if PlaylistPlayer?.rate == 0{
                //PlaylistPlayer!.play()
                //IsPlaylistPlaying = true
                //currentTrackplayBtn!.setImage(UIImage(named: "Pause.png"), for: .normal)
            }else{
                IsPlaylistPlaying = false
                PlaylistPlayer?.pause()
                //currentTrackplayBtn!.setImage(UIImage(named: "Play.png"), for: .normal)
            }
        }
        if Player != nil{
            if Player?.rate == 0
            {
                Player!.play()
                IsPlaying = true
                currentTrackplayBtn!.setImage(UIImage(named: "Pause.png"), for: .normal)
                
            } else {
                Player!.pause()
                IsPlaying = false
                currentTrackplayBtn!.setImage(UIImage(named: "Play.png"), for: .normal)
                
            }
        }
        
        if let index = feeds.index(of:CurrentTrack!){
            let indexPath = IndexPath(row : index,section:0)
            let cell = tableView.cellForRow(at: indexPath) as! FeedCell
            if IsPlaying{
                cell.playOrPauseBtn.setImage(UIImage(named: "Pause.png"), for: .normal)
            }else{
                cell.playOrPauseBtn.setImage(UIImage(named: "Play.png"), for: .normal)
            }
            
        }
        
    }
    
    func addToOrRemoveFromPlaylist(index: Int) {
        let data = feeds[index]
        var indexOfPlaylistItem = 1
        
        for task in (PlayListitems)! {
            if data.mp3Link == task.mp3Link {
                break
            }
            indexOfPlaylistItem += 1
        }
        let indexpath = IndexPath(row: index, section: 0)
        if indexOfPlaylistItem > (PlayListitems?.count)! || PlayListitems?.count == 0 {
            //not in list add to list
            PlayListitems?.append(data)
             let cell = (self.tableView.cellForRow(at: indexpath )) as! FeedCell
                cell.playListBtn.setImage(UIImage(named: "Minus.png"), for: .normal)
           
            
            
        }else{
            PlayListitems?.remove(at: indexOfPlaylistItem-1)
            let cell = (self.tableView.cellForRow(at: indexpath )) as! FeedCell
            cell.playListBtn.setImage(UIImage(named: "Plus.png"), for: .normal)
        }        
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        eName = elementName
        if elementName == "item"{
            feed = Feed()
            isItemTag = true
        }else if elementName == "media:content"{
            //print(attributeDict["url"] ?? "")
            feed.mp3Link = attributeDict["url"] ?? ""
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "title" && isItemTag{
            feed.title = feedTitle
        }else if elementName == "description" && isItemTag{
            print(feedDescription)
            feed.feedDescription = feedDescription
        }else if elementName == "itunes:subtitle" && isItemTag{
            feed.subtitle = feedSubTitle
        }else if elementName == "pubDate" && isItemTag{
            feed.pubDate = feedPubDate
        }else if elementName == "item"{
            isItemTag = false
            feeds.append(feed)
            print(feed)
        }else if elementName == "itunes:author" {
            feed.author = feedAuthor
        }else if elementName == "itunes:duration"{
            feed.duration = feedDuration
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in:NSCharacterSet.whitespacesAndNewlines)
        
        if(!data.isEmpty){
            if eName == "title"{
                feedTitle = data
            }else if eName == "description"{
                feedDescription = data
            }else if eName == "itunes:subtitle"{
                feedSubTitle = data
            }else if eName == "pubDate"{
                feedPubDate = data
            }else if eName == "itunes:author"{
                feedAuthor = data
            }else if eName == "itunes:duration"{
                feedDuration = data
            }
        }
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feeds.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell

        // Configure the cell...
        let data = feeds[indexPath.row]
        print(data)
        cell.data = data
        cell.delegate = self
        cell.indexOfThisCell = indexPath.row
        
        //change logic later
        var indexOfPlaylistItem = 1
        for task in (PlayListitems)! {
            if data.mp3Link == task.mp3Link {
                break
            }
            indexOfPlaylistItem += 1
        }
        
        if indexOfPlaylistItem > (PlayListitems?.count)! || PlayListitems?.count == 0 {
            //not in list 
            cell.playListBtn.setImage(UIImage(named: "Plus.png"), for: .normal)
        }else{
            cell.playListBtn.setImage(UIImage(named: "Minus.png"), for: .normal)
        }
        
        if CurrentTrack?.mp3Link == data.mp3Link && IsPlaying{
            cell.playOrPauseBtn.setImage(UIImage(named: "Pause.png"), for: .normal)
        }else{
            cell.playOrPauseBtn.setImage(UIImage(named: "Play.png"), for: .normal)
        }
        return cell
    }
    
    
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       /* currentTrackplayBtn.isHidden = false
        currentTrackplayBtn.isEnabled = true
        let data = feeds[indexPath.row]
        
        //set current track
        CurrentTrack = data
        
        currentTrackLabel.text = data.title
        
        //set current avplayer
        let url = URL(string : (data.mp3Link))
        let playerItem:AVPlayerItem = AVPlayerItem(url:url!)
        if let player = Player {
            if player.rate == 0{
                //is not playing
                
            }else{
                //is playing
                player.pause()
            }
        }
        TabController?.isPlaying = true
        Player = AVPlayer(playerItem:playerItem)
        Player?.play()
        currentTrackplayBtn.setImage(UIImage(named: "Pause.png"), for: .normal)
        IsPlaying = true
        //let cell = tableView.cellForRow(at: indexPath) as! FeedCell
        //cell.UpdateUIforSelection()*/
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //let cell = tableView.cellForRow(at: indexPath) as! FeedCell
        //cell.UpdateUIforDeSelection()
    }
    @IBAction func unwindToController(segue: UIStoryboardSegue) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let player = Player {
            if player.rate == 0{
                //is not playing
                
            }else{
                //is playing
                player.pause()
            }
        }
        
        let indexPath = self.tableView.indexPathForSelectedRow!
        if let secondVC = segue.destination.childViewControllers[0] as? PlayTrackController {
            
            secondVC.FullListitems = feeds
            secondVC.PlayListItems = PlayListitems!
            secondVC.Index = indexPath.row
            secondVC.delegate = self
            
        }
    }
    
    @objc func playerDidFinishPlaying(_ myNotification:NSNotification){
        
        
        currentTrackplayBtn.setImage(UIImage(named: "Play.png"), for: .normal)
        
        let index = feeds.index(of: CurrentTrack!)
        let indexPath = IndexPath(row : index!,section:0)
        let cell = tableView.cellForRow(at: indexPath) as! FeedCell
        cell.playOrPauseBtn.setImage(UIImage(named: "Play.png"), for: .normal)
        //playOrResumeBtn!.setImage(UIImage(named: "Play.png"), for: .normal)
        //delegate.UpdatePlayingStatus(isPlaying: false)
        
        
    }
    
    func CreateAVPlayer(playerItem : AVPlayerItem){
        
        Player = AVPlayer(playerItem:playerItem)
        
        //On finsihing
        NotificationCenter.default.addObserver(self,selector: #selector(PlaylistController.playerDidFinishPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
    }
    

}
