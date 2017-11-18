//
//  ControllerDelegate.swift
//  Homework2
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/23/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import Foundation
import AVFoundation

protocol  ControllerDelegate {
    
    func UpdateCurrentTrack(feed:Feed)
    func UpdatePlayingStatus(isPlaying:Bool)
    func addToOrRemoveFromPlaylist(index:Int)
    func UpdatePlayer(player:AVPlayer)
    
}
