//
//  EditAccountViewController.swift
//  QatarMeetups
//
//  Created by Emilio Cardenas on 11/27/22.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

var data = [Account] ()

class EditAccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePic.layer.cornerRadius = 68
        profilePic.clipsToBounds = true
        lblName.text = signUpUsername

        // Do any additional setup after loading the view.
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
            let newAccount = Account(context: context)
            newAccount.username = signUpUsername
            newAccount.email = signUpEmail
            newAccount.password = signUpPassword
            newAccount.teamsOfInterest = txtTeams.text!
            newAccount.nationality = txtNationality.text!
            newAccount.phoneNumber = txtPhoneNumber.text!
            newAccount.instagramAccount = txtInstagram.text!
            newAccount.profilePicture = profilePic.image?.pngData()
            
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
        performSegue(withIdentifier: "editToProfile", sender: self)
        
            
        
    }
    
    
    // Photo Album 
    @IBAction func btnPhotoAlbum(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    //This function is called automatically when an image is picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        profilePic.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
