//
//  NoteBook.swift
//  InClass06App
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

class NoteBook :  CustomStringConvertible {
    
   /* required convenience init?(dict: [String : AnyObject]) {
        
        guard let title = dict["Title"] as? String,let dateTime = dict["CreatedDateTime"] as? String else{
            return nil
        }
        if let notes = dict["Notes"] as? Array<Note>{
            self.notes = notes
        }else{
            return nil
        }
        self.init(name:title, dateTime:dateTime)
        
    }*/
    var notebookTitle:String=""
    
    var notebookDateTime:String=""
    
    var notes : Array<Note>?
    
    var notebookId:String=""
    
    init(name title:String, dateTime createdDateTime:String, id:String) {
        self.notebookTitle = title
        self.notebookDateTime = createdDateTime
        self.notebookId = id
    }
    
    init(dict: [String : AnyObject]) {
        
        if let id = dict["Id"] as? String{
            self.notebookId = id
        }
        if let title = dict["Title"] as? String{
            self.notebookTitle = title
        }
            
        if let dateTime = dict["CreatedDateTime"] as? String {
           self.notebookDateTime = dateTime
        }
        if let notes = dict["Notes"] as? Array<Note>{
            self.notes = notes
        }
    }
    var dict: [String : AnyObject]{
        return [
            "Id" : notebookId as AnyObject,
            "Title" : notebookTitle as AnyObject,
            "CreatedDateTime" : notebookDateTime as AnyObject,
            "Notes" : notes as AnyObject
        ]
    }
    var description: String{
        let space = " - "
        return notebookTitle + space + notebookDateTime
    }
}
