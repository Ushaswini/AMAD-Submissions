//
//  LoginController.swift
//  InClass07
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/26/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase
class LoginController: UIViewController {
    
    @IBOutlet weak var emailTf: UITextField!
    
    @IBOutlet weak var passwordTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(Auth.auth().currentUser != nil){
            
            UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "Current_User_Id")
            DispatchQueue.main.async {
                self.MoveToImageCollectionController()
            }
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func LoginBtnClicked(_ sender: Any) {
        
        if(isValidInput()){
            
            Auth.auth().signIn(withEmail: (emailTf?.text)!, password: (passwordTf?.text)!){(user,error) in
                if error == nil{
                    
                    print(user ?? "User")
                    UserDefaults.standard.set(user?.uid, forKey: "Current_User_Id")
                    self.MoveToImageCollectionController()
                }
                else{
                    print(error ?? "Error")
                    self.ShowAlert(message: (error?.localizedDescription)!)
                }
            }
        }else{
            //Show alert
            ShowAlert(message: "Invalid inputs")
        }
    }
    
    func MoveToImageCollectionController(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "NavForImagesController") as! UINavigationController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func isValidInput() -> Bool{
        
        let email = emailTf.text
        let password = passwordTf.text
        
        if email != nil && email != "" && password != nil && password != ""{
            return true
        }
        
        
        return false
    }
    
    func ShowAlert(message:String){
        
        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle:UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func unwindToController(segue: UIStoryboardSegue) {
        
    }
}

