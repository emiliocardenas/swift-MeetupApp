//
//  DemoTableViewCell.swift
//  QatarMeetups
//
//  Created by Emilio Cardenas on 11/25/22.
//

import UIKit


class DemoTableViewCell: UITableViewCell {
    
    static let identifier  = "DemoTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DemoTableViewCell", bundle: nil)
    }
    
    
    @IBOutlet var lblPlacePicture : UIImageView!
    @IBOutlet var lblPlaceName : UILabel!
    @IBOutlet var lblUsername : UILabel!
    @IBOutlet var lblDateTime : UILabel!
    @IBOutlet var lblGame : UILabel!
    @IBOutlet var lblAssistingNumber : UILabel!
    @IBOutlet var viewRounding : UIView!
    @IBOutlet var btnViewRounding : UIView!



    


    
    

    
    
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewRounding.layer.cornerRadius = 20;
        viewRounding.clipsToBounds = true;
        btnViewRounding.layer.cornerRadius = 10;
        btnViewRounding.clipsToBounds = true;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
