//
//  NotesController.swift
//  InClass06App
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase

class NotesController: UITableViewController {
    
    var noteBookId : String = ""
    
    var notesDatabaseRef : DatabaseReference!
    
    var currentUserUid = ""
    
    var notesList = Array<Note>()
    
    var CurrentTime : String{
        get{
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy hh:mm a"
            let result = formatter.string(from: date)
            return result
        }
    }

    
    @IBAction func AddBtnClicked(_ sender: Any) {
        
        let alertController = UIAlertController(title: "New Note", message: "Enter New Post Text", preferredStyle:UIAlertControllerStyle.alert)
        
        alertController.addTextField { (NameTf) in
            NameTf.placeholder = "Note Text"
        }
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        { action -> Void in
            
            if let title = alertController.textFields![0].text{
                
                if title != "" {
                    let newNoteRef = self.notesDatabaseRef.childByAutoId()
                    let newNotes = Note(note:title,dateTime:self.CurrentTime,id:newNoteRef.key,notebookId:self.noteBookId)
                
                    newNoteRef.setValue(newNotes.dict)
                }
            }
            
            
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default)
        { action -> Void in
            // Put your code here
        })
        self.present(alertController, animated: true, completion: nil)
    }
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let uid = UserDefaults.standard.string(forKey: "Current_User_Id"){
            currentUserUid = uid
        }
        notesDatabaseRef = Database.database().reference().child(currentUserUid).child("Notebooks").child(noteBookId).child("Notes")
        GetNotesForCurrentUser()

    }
    func GetNotesForCurrentUser(){
        notesDatabaseRef.observe(DataEventType.value, with: { (snapshot) in
            let notesDict = snapshot.value as? [String : AnyObject] ?? [:]
            print(notesDict)
            let notes = notesDict.flatMap{ (item) -> Note in
                return Note(dict:item.value as! [String : AnyObject])
                
            }
            self.notesList.removeAll()
            self.notesList.append(contentsOf : notes)
            self.tableView.reloadData()
            print(notes)
            
        })
        
    }
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath) as! NotesCell
        cell.data = notesList[indexPath.row]
        return cell
    }
}
