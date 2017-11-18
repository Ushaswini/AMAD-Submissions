//
//  ImageViewController.swift
//  InClass06App
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/26/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var currentImage : MyImage?
    
    var curUser = Auth.auth().currentUser
    let dbRef = Database.database().reference()
    let storageRef = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFill
        let imgURL = currentImage?.imageMetaURL
        if imgURL != "" {
        let url = NSURL(string: imgURL!)
        URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                DispatchQueue.main.async {
                    self.imageView?.image = UIImage(data: data!)
                }
            }).resume()
     
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteCurrentPhoto(_ sender: Any) {
        var alertController:UIAlertController?
        alertController = UIAlertController(title: "Delete", message: "Are you sure you want to delete the image", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: {[weak self] (paramAction:UIAlertAction!) in
            
            print((self?.currentImage?.imageKey)!)
            print((self!.curUser?.uid)!)
            self!.dbRef.child((self!.curUser?.uid)!).child("Images").child((self!.currentImage?.imageKey)!).setValue(nil)
            
            let imageName = (self!.currentImage?.imageName)! + ".png"
            self!.storageRef.child(imageName).delete(completion: { (error) in
                if error != nil {
                    let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(action)
                    self!.present(alert, animated: true, completion: nil)
                } else {
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc : UIViewController = storyboard.instantiateViewController(withIdentifier: "NavForImagesController") as UIViewController
                    self!.present(vc, animated: true, completion: nil)
                }
            })
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {[weak self] (paramAction:UIAlertAction!) in })
        
        alertController?.addAction(okAction)
        alertController?.addAction(cancelAction)
        present(alertController!, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
