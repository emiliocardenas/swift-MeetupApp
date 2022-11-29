//
//  SignInViewController.swift
//  QatarMeetups
//
//  Created by Emilio Cardenas on 11/27/22.
//

import UIKit
import CoreData

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblErrorMessage.isHidden = true

        // Do any additional setup after loading the view.
    }
    

    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblErrorMessage: UILabel!
    
    @IBAction func btnSignIn(_ sender: UIButton) {
        
        if txtEmail.text! != "" && txtPassword.text! != "" {
            // Retrieve data
            do {

                let request = Account.fetchRequest() as NSFetchRequest<Account>

                // Filter to not re-enter existing email
                let pred = NSPredicate(format: "email == %@", txtEmail.text!)

                request.predicate = pred

                data = try context.fetch(request)

                if data.count > 0 {
                    if data[0].password == txtPassword.text! {
                        signUpEmail = txtEmail.text!
                        performSegue(withIdentifier: "signInToProfile", sender: self)
                    }
                    else {
                        lblErrorMessage.isHidden = false
                        lblErrorMessage.text = "Invalid Password"
                    }


                }
                else {
                    lblErrorMessage.isHidden = false
                    lblErrorMessage.text = "Wrong email or password"
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
