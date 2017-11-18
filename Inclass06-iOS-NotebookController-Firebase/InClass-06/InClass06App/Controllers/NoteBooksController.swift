//
//  NoteBooksController.swift
//  InClass06App
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase

class NoteBooksController: UITableViewController {
    
    var notebooksDatabaseRef : DatabaseReference!
    
    var currentUserUid = ""
    
    var noteBooksList = Array<NoteBook>()
 
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
        
        let alertController = UIAlertController(title: "New Notebook", message: "Enter Notebook Name", preferredStyle:UIAlertControllerStyle.alert)
        
        alertController.addTextField { (NameTf) in
            NameTf.placeholder = "Notebook name"
        }
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        { action -> Void in
           
            if let title = alertController.textFields![0].text{
                if title != ""{
                    let newNotebookRef = self.notebooksDatabaseRef.childByAutoId()
                    let newNotebook = NoteBook(name:title,dateTime:self.CurrentTime,id: newNotebookRef.key)
                    newNotebookRef.setValue(newNotebook.dict)
                }
            }
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default)
        { action -> Void in
            // Put your code here
        })
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if(identifier == "GoToNotesSegue"){
           return true
            
        }else{
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                UserDefaults.standard.removeObject(forKey: "Current_User_Id")
                return true
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
                return false
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "GoToNotesSegue"){
            let indexPath = self.tableView.indexPathForSelectedRow!
            let data = noteBooksList[indexPath.row]
            if let secondVC = segue.destination as? NotesController {
                
                secondVC.noteBookId = data.notebookId
                
                
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let uid = UserDefaults.standard.string(forKey: "Current_User_Id"){
            currentUserUid = uid
        }
        
        //auto adjust the height of row
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        notebooksDatabaseRef = Database.database().reference().child(currentUserUid).child("Notebooks")
        GetNotebooksForCurrentUser()
        
    }

    func GetNotebooksForCurrentUser(){
        
        notebooksDatabaseRef.observe(DataEventType.value, with: { (snapshot) in
            
            let noteBookDict = snapshot.value as? [String : AnyObject] ?? [:]
            // ...
            print(noteBookDict)
            let notebooks = noteBookDict.flatMap{ (item) -> NoteBook in
                return NoteBook(dict:item.value as! [String : AnyObject])
            }
            self.noteBooksList.removeAll()
            self.noteBooksList.append(contentsOf : notebooks)
            self.tableView.reloadData()
            print(notebooks)
            
        })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return noteBooksList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotebookCell", for: indexPath) as! NoteBookCell
        cell.data = noteBooksList[indexPath.row]
        return cell
    }
}
