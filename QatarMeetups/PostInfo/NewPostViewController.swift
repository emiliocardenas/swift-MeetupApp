//
//  NewPostViewController.swift
//  QatarMeetups
//
//  Created by Emilio Cardenas on 11/29/22.
//

import UIKit
import CoreData

var postData = [Post] ()

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var flag = 0
    
    @IBAction func addImage1(_ sender: UIButton) {
        flag = 1
        let imagePicker = UIImagePickerController()

        imagePicker.delegate = self

        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true

        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func addImage2(_ sender: UIButton) {
        flag = 2
        let imagePicker = UIImagePickerController()

        imagePicker.delegate = self

        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true


        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func addImage3(_ sender: UIButton) {
        flag = 3
        
        let imagePicker = UIImagePickerController()

        imagePicker.delegate = self

        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true


        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var txtPlaceName: UITextField!
    @IBOutlet weak var txtCityName: UITextField!
    @IBOutlet weak var txtRating: UITextField!
    @IBOutlet weak var txtPostReview: UITextField!
    @IBAction func submitPost(_ sender: UIButton) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
//        print(dateFormatter.string(from: date))
        let newImage1 = Images(context: context)
        newImage1.placeImage = img1.image?.pngData()
        
        let newImage2 = Images(context: context)
        newImage2.placeImage = img2.image?.pngData()
        
        let newImage3 = Images(context: context)
        newImage3.placeImage = img3.image?.pngData()
//        newAccount.profilePicture = profilePic.image?.pngData()

        
        let newPost = Post(context: context)
        newPost.placeName = txtPlaceName.text!
        newPost.cityName = txtCityName.text!
        newPost.date = dateFormatter.string(from: date)
        newPost.review = txtPostReview.text!
        newPost.rating = txtRating.text!
        newPost.addToPeople(data[0])
        newPost.addToImageGroup(newImage1)
        newPost.addToImageGroup(newImage2)
        newPost.addToImageGroup(newImage3)

        
        
        
        appDelegate.saveContext()
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if flag == 1 {
            img1.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }
        else if flag == 2{
            img2.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }
        else if flag == 3 {
            img3.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage

        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func clearPosts(_ sender: UIButton) {
        // Initialize Fetch Request

        // Configure Fetch Request

        do {
            let postData = try context.fetch(Post.fetchRequest())


            for item in postData {
                context.delete(item)
            }

            // Save Changes
            appDelegate.saveContext()

        } catch {
            // Error Handling
            // ...
        }
    }
    
    //            // Display data
    //            var data = [Account] ()
    //
    //            do {
    //                data = try context.fetch(Account.fetchRequest())
    //                for existingAccount in data {
    //                    print ("Account \(existingAccount.username!), \(existingAccount.email!), \(existingAccount.password!), \(existingAccount.teamsOfInterest!), \(existingAccount.nationality!), \(existingAccount.instagramAccount!), \(existingAccount.profilePicture!)")
    //                }
    //
    //            }
    //            catch {}
    
    
    
    

}
