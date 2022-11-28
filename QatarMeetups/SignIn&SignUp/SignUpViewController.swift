//
//  SignUpViewController.swift
//  QatarMeetups
//
//  Created by Emilio Cardenas on 11/27/22.
//

import UIKit
import CoreData

var signUpUsername : String = "no username"
var signUpEmail : String = "no email"
var signUpPassword : String  = "no password"


class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        lblErrorMessage.isHidden = true

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblErrorMessage: UILabel!
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        
        if txtName.text! != "" && txtEmail.text! != "" && txtPassword.text! != "" {

            
        // Retrieve data
        var emailData = [Account] ()
        
        do {
            
            let request = Account.fetchRequest() as NSFetchRequest<Account>
            
            // Filter to not re-enter existing email
            let pred = NSPredicate(format: "email == %@", txtEmail.text!)
            
            request.predicate = pred
            
            emailData = try context.fetch(request)
            
            if emailData.count > 0 {
                lblErrorMessage.isHidden = false
                lblErrorMessage.text = "Existing email, please use another email."
                
            }
            else {
                signUpUsername = txtName.text!
                signUpEmail = txtEmail.text!
                signUpPassword = txtPassword.text!
                performSegue(withIdentifier: "signUpToEdit", sender: self)
            }
        }
        catch {}

        }
        else {
            lblErrorMessage.text = "Please fill all fields"
            lblErrorMessage.isHidden = false
        }
        

    }
    

        
        
        
        
    
    
    
    
}
