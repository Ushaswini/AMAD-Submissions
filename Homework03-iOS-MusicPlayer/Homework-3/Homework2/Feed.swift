//
//  Feed.swift
//  Homework2
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/21/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import Foundation
class Feed : NSObject,NSCoding{
    
    /*var description: String{
        return title + " - " + subtitle + " - " + pubDate + " - " + feedDescription + " - " + mp3Link + " - " + author
    }
    */
    
    var title:String = ""
    
    var subtitle:String = ""
    
    var pubDate = ""
    
    var mp3Link = ""
    
    var feedDescription = ""
    
    var author = ""
    
    var duration = ""
    
    override init(){
        
    }
    required init(coder decoder: NSCoder) {
        self.title = decoder.decodeObject(forKey: "title") as? String ?? ""
        self.subtitle = decoder.decodeObject(forKey: "subtitle") as? String ?? ""
        self.pubDate = decoder.decodeObject(forKey: "pubDate") as? String ?? ""
        self.mp3Link = decoder.decodeObject(forKey: "mp3Link") as? String ?? ""
        self.feedDescription = decoder.decodeObject(forKey: "feedDescription") as? String ?? ""
        self.author = decoder.decodeObject(forKey: "author") as? String ?? ""
        self.duration = decoder.decodeObject(forKey: "duration") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(subtitle, forKey: "subtitle")
        coder.encode(pubDate, forKey: "pubDate")
        coder.encode(mp3Link, forKey: "mp3Link")
        coder.encode(feedDescription, forKey: "feedDescription")
        coder.encode(author, forKey: "author")
        coder.encode(duration, forKey: "duration")
    }
    
    
    
    
}
