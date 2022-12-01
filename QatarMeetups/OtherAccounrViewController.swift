//
//  OtherAccounrViewController.swift
//  QatarMeetups
//
//  Created by Emilio Cardenas on 11/30/22.
//

import UIKit

class OtherAccounrViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        imgProfilePic.layer.cornerRadius = 68
        imgProfilePic.clipsToBounds = true
        
        imgProfilePic.image = UIImage(data: (otherAccount?.profilePicture)!)
        lblUsername.text = (otherAccount?.username)!
        lblTeams.text = (otherAccount?.teamsOfInterest)!
        lblNationality.text = (otherAccount?.nationality)!
        lblPhoneNumber.text = (otherAccount?.phoneNumber)!
        lblInstaAccount.text = (otherAccount?.instagramAccount)!
    }
    
    var otherAccount : Account?
    

    @IBOutlet weak var imgProfilePic: UIImageView!
    
    @IBOutlet weak var lblUsername: UILabel!
    
    @IBOutlet weak var lblTeams: UILabel!
    
    @IBOutlet weak var lblNationality: UILabel!
    
    @IBOutlet weak var lblPhoneNumber: UILabel!
    
    @IBOutlet weak var lblInstaAccount: UILabel!
    
    
    
    @IBAction func btnBackToNav(_ sender: UIButton) {
        performSegue(withIdentifier: "backToNav", sender: self)
    }
    
}
