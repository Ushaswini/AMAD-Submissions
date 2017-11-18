//
//  FeedCellDelegator.swift
//  Homework2
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/22/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import Foundation

protocol FeedCellDelegator {
    func addToOrRemoveFromPlaylist(index: Int)
    func playOrPausePlayer(index:Int, play:Bool)
}
