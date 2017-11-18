//
//  RowCell.swift
//  Homework2
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/9/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import Foundation

class RowCell : CustomStringConvertible{
    
    
    
    var category : String = ""
    var artist : String = ""
    var name : String = ""
    var squareImage : String = ""
    var price:Double = 0.0
    var releaseDate:String=""
    
    
    var summary:String?
    var otherImage : String?
    
    
    init(json : [String:Any]) {
        
        if let categoryJSON = json["category"] as? [String: Any]{
            if let attributesJSON = categoryJSON["attributes"] as? [String: Any]{
                if let category = attributesJSON["term"] as? String{
                    self.category = category
                }
            }
        }
        if let artistJSON = json["artist"] as? [String: Any]{
            if let artist = artistJSON["label"] as? String{
                self.artist = artist
            }
        }
        if let nameJSON = json["name"] as? [String: Any]{
            if let name = nameJSON["label"] as? String{
                self.name = name
            }
        }
        if let priceJSON = json["price"] as? [String: Any]{
            if let price = priceJSON["amount"] as? Double{
                self.price = price
            }
        }
        if let releaseDateJSON = json["releaseDate"] as? [String: Any]{
            if let releaseDate = releaseDateJSON["label"] as? String{
                self.releaseDate = releaseDate
            }
        }
        if let summaryJSON = json["summary"] as? [String: Any]{
            if let summary = summaryJSON["label"] as? String{
                self.summary = summary
            }
        }
        
        if let squareImageJSON = json["squareImage"] as? [[String: Any]]{
            if let squareJSON = squareImageJSON.first{
                if let squareImage = squareJSON["label"] as? String{
                    self.squareImage = squareImage
                }
            }
        }
        if let otherImageJSON = json["otherImage"] as? [[String: Any]]{
            if let otherJSON = otherImageJSON.first{
                if let otherImage = otherJSON["label"] as? String{
                    self.otherImage = otherImage
                }
            }
        }
    }
    
    var description : String{
        
        get{
            let space = " - "
            return artist + space + category + space +  name + space + squareImage + space +  String(price) + space +  releaseDate 
        }
    }
    
    
}
