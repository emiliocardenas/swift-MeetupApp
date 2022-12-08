//
//  MyProfileViewController.swift
//  QatarMeetups
//
//  Created by Emilio Cardenas on 11/27/22.
//

import UIKit

class MyProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        imgProfilePic.layer.cornerRadius = 68
        imgProfilePic.clipsToBounds = true
        
        imgProfilePic.image = UIImage(data: data[0].profilePicture!)
        lblUsername.text = data[0].username!
        lblTeams.text = data[0].teamsOfInterest!
        lblNationality.text = data[0].nationality!
        lblPhoneNumber.text = data[0].phoneNumber!
        lblInstaAccount.text = data[0].instagramAccount!
    }
    

    @IBOutlet weak var imgProfilePic: UIImageView!
    
    @IBOutlet weak var lblUsername: UILabel!
    
    @IBOutlet weak var lblTeams: UILabel!
    
    @IBOutlet weak var lblNationality: UILabel!
    
    @IBOutlet weak var lblPhoneNumber: UILabel!
    
    @IBOutlet weak var lblInstaAccount: UILabel!
    
    
    @IBAction func btnLogout(_ sender: UIButton) {
        performSegue(withIdentifier: "logOutToLogin", sender: self)
    }
    
    
    @IBAction func btnToEdit(_ sender: UIButton) {
        performSegue(withIdentifier: "profileToEdit", sender: self)
    }
}
