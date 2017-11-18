//
//  MyImage.swift
//  InClass06App
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/26/17.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

class MyImage{
    
    var imageMetaURL : String = ""
    var imageKey : String = ""
    var imageName : String = ""
    
    init(dict: [String : AnyObject]) {
        
        if let url = dict["ImageMetaURL"] as? String{
            self.imageMetaURL = url
        }
        if let key = dict["ImageKey"] as? String{
            self.imageKey = key
        }
        
        if let name = dict["ImageName"] as? String {
            self.imageName = name
        }
        
    }
    
    init(key title:String, url:String, name:String) {
        self.imageKey = title
        self.imageMetaURL = url
        self.imageName = name
    }
    
    var dict: [String : AnyObject]{
        return [
            "ImageMetaURL" : imageMetaURL as AnyObject,
            "ImageKey" : imageKey as AnyObject,
            "ImageName" : imageName as AnyObject,
            
        ]
    }
}
