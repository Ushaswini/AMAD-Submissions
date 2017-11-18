//
//  ImagesCollectionController.swift
//  InClass06App
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/26/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase

class ImagesCollectionController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var listOfImages = [MyImage]()
    
    var currentUser = Auth.auth().currentUser!
    
    let imagePicker = UIImagePickerController()
    
    var currentUserReference : DatabaseReference! = nil
    
    let storageRef = Storage.storage().reference()
    
    var myImages = [MyImage]()
    
     @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        currentUserReference = Database.database().reference().child((currentUser.uid))
        
        GetImagesForCurrentUser()
    }

   

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as? ImageViewCell
        
        let imgObj = self.myImages[indexPath.row]
        print("in cell \(indexPath.row)")
        cell!.imageView.contentMode = .scaleAspectFill
        
        let UrlToDownLoadImage = imgObj.imageMetaURL
        if UrlToDownLoadImage != "" {
        
        let url = NSURL(string: UrlToDownLoadImage)
            
        URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
            
                //print("download image \(indexPath.row)")
            if error != nil {
                print(error ?? "")
                return
            }
            DispatchQueue.main.async {
                cell!.imageView?.image = UIImage(data: data!)
            }
                
                
            }).resume()
        }
        return cell!
    }
    
    
    func GetImagesForCurrentUser() {
        
        currentUserReference.child("Images").observe(DataEventType.value, with: { (snapshot) in
            
            let imagesDict = snapshot.value as? [String : AnyObject] ?? [:]
            // ...
            print(imagesDict)
            let images = imagesDict.flatMap{ (item) -> MyImage in
                return MyImage(dict:item.value as! [String : AnyObject])
            }
            self.myImages.removeAll()
            self.myImages.append(contentsOf : images)
            self.collectionView.reloadData()
            
            print(images)
            
        })
        
    }
    @IBAction func logoutUser(sender: AnyObject) {
        try! Auth.auth().signOut()
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : UIViewController = storyboard.instantiateViewController(withIdentifier: "LoginStoryBoard") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func addPhotoToAlbum(sender: AnyObject) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] {
            selectedImageFromPicker = editedImage as? UIImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] {
            selectedImageFromPicker = originalImage as? UIImage
        }
        dismiss(animated: true, completion: nil)
        let imageName = NSUUID().uuidString
        
        let storageRef = self.storageRef.child("\(imageName).png")
        if let uploadData = UIImagePNGRepresentation(selectedImageFromPicker!) {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error)
                    return
                } else {
                    let newImageURLVal = metadata?.downloadURL()?.absoluteString
                    //print(newImageURLVal)
                    let newImageRef = self.currentUserReference.child("Images").childByAutoId()
                    let newImage = MyImage(key: newImageRef.key, url: newImageURLVal!, name: imageName)
                    
                    newImageRef.setValue(newImage.dict)
                }
                
            })
        }
    }
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myImages.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
 
    
    /*func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showImage", sender: self)
    }*/
    
  
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage" {
            //print("moving now")
            let indexPaths = self.collectionView.indexPathsForSelectedItems!
            let indexPath = indexPaths[0]
            let imageVC = segue.destination as? ImageViewController
            imageVC!.currentImage = self.myImages[indexPath.row]
     }
    }
 

}
