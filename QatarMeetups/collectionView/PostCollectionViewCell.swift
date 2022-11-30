//
//  PostCollectionViewCell.swift
//  QatarMeetups
//
//  Created by Emilio Cardenas on 11/29/22.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImageView : UIImageView!
    
    func configure(image: UIImage){
        slideImageView.image = image
    }
    
}
