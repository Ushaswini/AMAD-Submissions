//
//  ViewController.swift
//  InClass03
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 9/21/17.
//  Copyright © 2017 Vinnakota, Venkata Ratna Ushaswini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var FirstNumber: UITextField!
    @IBOutlet weak var SecondNumber: UITextField!
    
    @IBOutlet weak var Result: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func OnAddClicked(_ sender: Any) {
        
        FirstNumber.resignFirstResponder();
        SecondNumber.resignFirstResponder();
        
        
        var first:String? = FirstNumber.text
        var second:String? = SecondNumber.text
        
        if(first == "."){
            first="0."
            FirstNumber.text="0."
        }
        if(second == "."){
            second="0."
            SecondNumber.text="0."
        }
        
        if(first == "" || second == ""){
            
            let alert = UIAlertController(title: "Wrong Input", message: "Inputs can't be emty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                self.FirstNumber.text=""
                self.SecondNumber.text=""
            }))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let first:Double? = Double(first!)
            let second:Double? = Double(second!)
        
        let result:Double = first! + second!
        Result.text = "Result: \(result)"
        }
    }
    
    @IBAction func OnSubtractClicked(_ sender: Any) {
        
        FirstNumber.resignFirstResponder();
        SecondNumber.resignFirstResponder();
        
        
        var first:String? = FirstNumber.text
        var second:String? = SecondNumber.text
        
        if(first == "."){
            first="0."
            FirstNumber.text="0."
        }
        if(second == "."){
            second="0."
            SecondNumber.text="0."
        }
        
        if(first == "" || second == ""){
            
            let alert = UIAlertController(title: "Wrong Input", message: "Inputs can't be emty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                self.FirstNumber.text=""
                self.SecondNumber.text=""
            }))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let first:Double? = Double(first!)
            let second:Double? = Double(second!)
        
        let result:Double = first! - second!
        Result.text = "Result: \(result)"
        }
    }
    @IBAction func OnMultiplyClicked(_ sender: Any) {
        FirstNumber.resignFirstResponder();
        SecondNumber.resignFirstResponder();
        
        
        var first:String? = FirstNumber.text
        var second:String? = SecondNumber.text
        
        if(first == "."){
            first="0."
            FirstNumber.text="0."
        }
        if(second == "."){
            second="0."
            SecondNumber.text="0."
        }
        
        if(first == "" || second == ""){
            
            let alert = UIAlertController(title: "Wrong Input", message: "Inputs can't be emty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                self.FirstNumber.text=""
                self.SecondNumber.text=""
            }))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let first:Double? = Double(first!)
            let second:Double? = Double(second!)
            
            let result:Double = first! * second!
            Result.text = "Result: \(result)"
        }
        
        
        
    }
    
    @IBAction func OnDivideClicked(_ sender: Any) {
        FirstNumber.resignFirstResponder();
        SecondNumber.resignFirstResponder();
        
        var first:String? = FirstNumber.text
        var second:String? = SecondNumber.text
        
        if(first == "."){
            first="0."
            FirstNumber.text="0."
        }
        if(second == "."){
            second="0."
            SecondNumber.text="0."
        }
        
        if(first == "" || second == ""){
            
            let alert = UIAlertController(title: "Wrong Input", message: "Inputs can't be emty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                self.FirstNumber.text=""
                self.SecondNumber.text=""
            }))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let first:Double? = Double(first!)
            let second:Double? = Double(second!)
        
        if(second == 0){
            
            let alert = UIAlertController(title: "Wrong Input", message: "Can't divide by zero", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                self.FirstNumber.text=""
                self.SecondNumber.text=""
            }))
            self.present(alert, animated: true, completion: nil)
        }else{
            let result:Double = first! / second!
            Result.text = "Result: \(result)"
            }
        }
    }
    
    @IBAction func OnClearAllClicked(_ sender: Any) {
        FirstNumber.text=""
        SecondNumber.text=""
        Result.text="Result:"
        
    }
    
}

