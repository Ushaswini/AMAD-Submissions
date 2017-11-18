//
//  SignUpController.swift
//  InClass07
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/26/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    
    @IBOutlet weak var ConfirmPasswordTf: UITextField!
    
    @IBOutlet weak var PasswordTf: UITextField!
    
    @IBOutlet weak var EmailTf: UITextField!
    
    @IBOutlet weak var NameTf: UITextField!
    
    var usersDatabaseRef : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersDatabaseRef = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SubmitBtnClicked(_ sender: Any) {
        if(isValidInput()){
            Auth.auth().createUser(withEmail: (EmailTf?.text)!, password: PasswordTf.text!){ (user, error) in
                
                if error == nil {
                    print(user ?? "")
                    
                    if let userId = user?.uid{
                        
                       let userObj = User(id:userId,userName:(self.NameTf?.text)!,userNoteBooks:Array<MyImage>())
                        
                        self.usersDatabaseRef.child(userId).setValue(userObj.dict);
                    }
                    UserDefaults.standard.set(user?.uid, forKey: "Current_User_Id")
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "NavForImagesController") as! UINavigationController
                    self.present(newViewController, animated: true, completion: nil)
                    
                }else{
                    //display alert
                    print(error ?? "Error")
                    self.ShowAlert(message: (error?.localizedDescription)!)
                }
                
            }
        }
        else{
            //display alert
            ShowAlert(message: "Invalid inputs")
        }
    }
    
    func isValidInput() -> Bool{
        
        let email = EmailTf.text
        let userName = NameTf.text
        let password = PasswordTf.text
        let confirmPassword = ConfirmPasswordTf.text
        
        if email != nil && email != "" && password != nil && password != "" && userName != nil && userName != "" && confirmPassword != nil && confirmPassword != "" && password == confirmPassword{
            return true
        }
        
        
        return false
    }
    func ShowAlert(message:String){
        
        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle:UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}

