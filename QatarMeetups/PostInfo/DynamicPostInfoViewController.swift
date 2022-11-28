//
//  DynamicPostInfoViewController.swift
//  QatarMeetups
//
//  Created by Emilio Cardenas on 11/25/22.
//

import UIKit

class DynamicPostInfoViewController: UIViewController {

    override func viewDidLoad() {
//        super.viewDidLoad()
        lblPlaceName.text = "\(incomingText!)"

        // Do any additional setup after loading the view.
    }
    
    var incomingText : String?

    @IBOutlet weak var lblPlaceName: UILabel!
}
