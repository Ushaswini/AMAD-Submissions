//
//  Note.swift
//  InClass06App
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/21/17.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

class Note :  CustomStringConvertible {
    
    var noteBody : String = ""
    
    var noteCreatedDateTime : String = ""
    
    var noteId:String = ""
    
    var notebookId:String = ""
    
    var dict: [String : AnyObject]{
        return [
            "Id": noteId as AnyObject,
            "Body" : noteBody as AnyObject,
            "CreatedDateTime" : noteCreatedDateTime as AnyObject,
            "NoteBookId" : notebookId  as AnyObject
        ]
    }
     init(dict: [String : AnyObject]) {
        
        if let id = dict["Id"] as? String{
            self.noteId = id
        }
        if let body = dict["Body"] as? String{
            self.noteBody = body
        }
        if let dateTime = dict["CreatedDateTime"] as? String {
            self.noteCreatedDateTime = dateTime
        }
        if let notebookId = dict["NoteBookId"] as? String{
            self.notebookId = notebookId
        }
    }
   
    
    init(note body:String, dateTime createdDateTime :String,id:String, notebookId:String) {
        self.noteBody = body
        self.noteCreatedDateTime = createdDateTime
        self.noteId = id
        self.notebookId = notebookId
    }
    
    var description: String {
        
        let space = " - "
        return noteBody + space + noteCreatedDateTime
    }
    
}
