//
//  ViewController.swift
//  InClass03b
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 9/22/17.
//  Copyright © 2017 Vinnakota, Venkata Ratna Ushaswini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var SecondNumber: UITextField!
    
    @IBOutlet weak var FirstNumber: UITextField!
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    

    
    @IBOutlet weak var Result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Clear(_ sender: Any) {
      
    }
    @IBAction func ClearAll(_ sender: Any) {
        FirstNumber.text=""
        SecondNumber.text=""
        Result.text="Result:"
        
    }
    
  
    @IBAction func PerformOperation(_ sender: Any) {
        
        FirstNumber.resignFirstResponder();
        SecondNumber.resignFirstResponder();
        
        var result:Double = 0
        var first:String? = FirstNumber.text
        var second:String? = SecondNumber.text
        
        if(FirstNumber.text=="."){
            first="0."
            FirstNumber.text="0."
        }
        if(SecondNumber.text=="."){
            second="0."
            SecondNumber.text="0."
        }
        
        if(first == "" || second == "")
        {
            let alert = UIAlertController(title: "Wrong Input", message: "Inputs can't be emty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                    self.FirstNumber.text=""
                    self.SecondNumber.text=""
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let first:Double? = Double(first!)
            let second:Double? = Double(second!)
            
            switch(segmentedControl.selectedSegmentIndex){
            case 0:result = first! + second!
                break
            case 1:result = first!-second!
                break;
            case 2:result = first! * second!
                break;
            case 3: if(second == 0)
                {
                    let alert = UIAlertController(title: "Wrong Input", message: "Can't divide by zero", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                        self.FirstNumber.text=""
                        self.SecondNumber.text=""
                        self.Result.text="Result:"
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    result = first! / second!
                }
                break
            default:
                break
            }
            
            Result.text="Result: \(result)"
            
        }
    
    }
    
    
}

