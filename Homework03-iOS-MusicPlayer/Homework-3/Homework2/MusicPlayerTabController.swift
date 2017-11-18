//
//  MusicPlayerTabController.swift
//  Homework2
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/18/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayerTabcontroller : UITabBarController{
    
    var playListItems : [Feed]{
        
        get{
            if let data = UserDefaults.standard.data(forKey: "PlaylistItems"){
                if let feedList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Feed] {
                    return feedList
                }
                return [Feed]()
            
            
            }else{
                return [Feed]()
            }
    
        }
        set{
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: newValue)
            UserDefaults.standard.set(encodedData, forKey: "PlaylistItems")
            UserDefaults.standard.synchronize()
        }
    }
    var currentTrack : Feed?
    
    var currentPlaylistTrack : Feed?
    
    var player : AVPlayer?
    
    var isPlaying : Bool = false
    
    var currentIndex : Int = 0
    
    var isPlaylistPlaying = false
    
    var playListPlayer : AVPlayer?
    
    
}
