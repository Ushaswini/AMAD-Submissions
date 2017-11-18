//
//  User.swift
//  InClass06App
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/21/17.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

class User  {
    
    required convenience init?(dict: [String : AnyObject]) {
        
        guard let id = dict["UserId"] as? String,
            let userName = dict["UserName"] as? String,
            let noteBooks = dict["UserImages"] as? Array<MyImage> else{
            return nil
            
        }
        self.init(id:id, userName:userName,userNoteBooks:noteBooks)
    }
    
    var dict: [String : AnyObject]{
        return [
            "UserId" : userId as AnyObject,
            "UserName" : userName as AnyObject,
            "UserNoteBooks" : userImages as AnyObject
        ]
    }
    
    init(id userId:String, userName: String, userNoteBooks:Array<MyImage> ) {
        self.userId = userId
        self.userName = userName
        self.userImages = userNoteBooks
    }
    var userId:String = ""
    var userName:String = ""
    var userImages : Array<MyImage>
}
