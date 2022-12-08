//
//  NewPostViewController.swift
//  QatarMeetups
//
//  Created by Emilio Cardenas on 11/29/22.
//

import UIKit
import CoreData
import CoreLocation


var postData = [Post] ()

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnClearAllData.isHidden = true
        btnClearAllData.isEnabled = false

        // Do any additional setup after loading the view.
        
        txtPlaceName.delegate = self
        txtPlaceName.returnKeyType = .done
        txtCityName.delegate = self
        txtCityName.returnKeyType = .done
        txtRating.delegate = self
        txtRating.returnKeyType = .done
        txtPostReview.delegate = self
        txtPostReview.returnKeyType = .done
        
        
        

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        txtPlaceName.resignFirstResponder()
        txtCityName.resignFirstResponder()
        txtRating.resignFirstResponder()
        txtPostReview.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btnClearAllData.isHidden = true
        btnClearAllData.isEnabled = false
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
    
    @IBOutlet weak var btnClearAllData: UIButton!
    
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
        newPost.addToImageGroup(newImage1)
        newPost.addToImageGroup(newImage2)
        newPost.addToImageGroup(newImage3)
        if locationManager.location?.coordinate != nil {
            newPost.longitude = "\((locationManager.location?.coordinate.longitude)!)"
            newPost.latitude = "\((locationManager.location?.coordinate.latitude)!)"
        }
        else {
            print("emtpy coordinate")
        }

        if data[0].post == nil {
            newPost.addToPeople(data[0])
        }
        else {
//            let cloneAccount  = Account(context: context)
            let cloneAccount = Account(context: context)
            cloneAccount.username = data[0].username!
            cloneAccount.teamsOfInterest = data[0].teamsOfInterest!
            cloneAccount.nationality = data[0].nationality!
            cloneAccount.phoneNumber = data[0].phoneNumber!
            cloneAccount.instagramAccount = data[0].instagramAccount!
            cloneAccount.profilePicture = data[0].profilePicture!
            
            newPost.addToPeople(cloneAccount)
            
        }
        
        appDelegate.saveContext()
        performSegue(withIdentifier: "newPostToFeed", sender: self)
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
            let postDatas = try context.fetch(Post.fetchRequest())


            for item in postDatas {
                context.delete(item)
            }

            // Save Changes
            appDelegate.saveContext()

        } catch {
            // Error Handling
            // ...
        }
        
        do {
            let datas = try context.fetch(Account.fetchRequest())


            for item in datas {
                context.delete(item)
            }

            // Save Changes
            appDelegate.saveContext()

        } catch {
            // Error Handling
            // ...
        }
    }
    

    
    let locationManager = CLLocationManager()
    
    @IBAction func btnHandleLocation(_ sender: UIButton) {
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            print("in btn:", locationInfoLongitude)
//            print((locationManager.location?.coordinate)!)

        }
    }
    
    var locationInfoLongitude : Double = 0
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationInfoLongitude = location.coordinate.longitude
            print("Location Manager:", location.coordinate.longitude)
            
        }
        locationManager.stopUpdatingLocation()

    }
    
    
    
    
    

}
