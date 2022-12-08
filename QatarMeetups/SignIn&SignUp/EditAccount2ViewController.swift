//
//  EditAccount2ViewController.swift
//  QatarMeetups
//
//  Created by Emilio Cardenas on 12/5/22.
//

import UIKit
import CoreData

class EditAccount2ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePic.layer.cornerRadius = 68
        profilePic.clipsToBounds = true
        lblName.text = data[0].username!
        txtTeams.text = data[0].teamsOfInterest!
        txtNationality.text = data[0].nationality!
        txtPhoneNumber.text = data[0].phoneNumber!
        txtInstagram.text = data[0].instagramAccount!
        profilePic.image = UIImage(data: data[0].profilePicture!)
        // Do any additional setup after loading the view.
        
        txtTeams.delegate = self
        txtTeams.returnKeyType = .done
        
        txtNationality.delegate = self
        txtNationality.returnKeyType = .done
        
        txtPhoneNumber.delegate = self
        txtPhoneNumber.returnKeyType = .done
        
        txtInstagram.delegate = self
        txtInstagram.returnKeyType = .done
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        txtTeams.resignFirstResponder()
        txtNationality.resignFirstResponder()
        txtPhoneNumber.resignFirstResponder()
        txtInstagram.resignFirstResponder()
        return true
    }
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    
    @IBOutlet weak var txtTeams: UITextField!
    

    @IBOutlet weak var txtNationality: UITextField!
    

    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    
    @IBOutlet weak var txtInstagram: UITextField!
    
    
    
    @IBAction func saveAccountInfo(_ sender: UIButton) {
        
        if txtTeams.text! != "" && txtNationality.text! != "" && txtPhoneNumber.text != "" && txtInstagram.text! != "" {
            
            // Create an Account Object
            
             
//            data[0].username = signUpUsername
//            data[0].email = signUpEmail
//            newAccount.password = signUpPassword
            data[0].teamsOfInterest = txtTeams.text!
            data[0].nationality = txtNationality.text!
            data[0].phoneNumber = txtPhoneNumber.text!
            data[0].instagramAccount = txtInstagram.text!
            data[0].profilePicture = profilePic.image?.pngData()
            
            // Save the data
            appDelegate.saveContext()
            
            
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
            

            
            // Retrieve data based on email (unique value)
            do {
                
                let request = Account.fetchRequest() as NSFetchRequest<Account>
                
                // Filter to not re-enter existing email
                let pred = NSPredicate(format: "email == %@", signUpEmail)
                
                request.predicate = pred
                
                data = try context.fetch(request)
                
//                print(data[0])
                
            }
            catch {}
            
        }
        performSegue(withIdentifier: "edit2ToNav", sender: self)
        
            
        
    }
    
    
    @IBAction func btnCamera(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        //Check if camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            
            if UIImagePickerController.isCameraDeviceAvailable(.front){
                imagePicker.cameraDevice = .front
            }
            else {
                imagePicker.cameraDevice = .rear
            }
        
        }
        
        else {
            imagePicker.sourceType = .photoLibrary
        }
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    // Photo Album
    @IBAction func btnPhotoAlbum(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.allowsEditing = true
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    //This function is called automatically when an image is picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        profilePic.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
