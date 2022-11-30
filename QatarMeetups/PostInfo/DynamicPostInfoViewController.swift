//
//  DynamicPostInfoViewController.swift
//  QatarMeetups
//
//  Created by Emilio Cardenas on 11/25/22.
//

import UIKit
import CoreData

class DynamicPostInfoViewController: UIViewController {
    
    var desiredAccounts = [Account] ()
    var desiredImages = [Images] ()

    @IBOutlet weak var collectionView: UICollectionView!
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.layer.cornerRadius = 20
        collectionView.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let request = Account.fetchRequest() as NSFetchRequest<Account>
            
            // Filter to not re-enter existing email
            let pred = NSPredicate(format: "post == %@", incomingText!)
            
            request.predicate = pred
            
            desiredAccounts = try context.fetch(request)
        }
        catch {
//            print(error)
        }
        
        do {
            let imageRequest = Images.fetchRequest() as NSFetchRequest<Images>
            
            // Filter to not re-enter existing email
            let pred = NSPredicate(format: "post == %@", incomingText!)
            
            imageRequest.predicate = pred
            
            desiredImages = try context.fetch(imageRequest)
        }
        catch {}
        
        lblPlaceName.text = "\((incomingText?.placeName)!)"
        lblPostedByName.text = desiredAccounts[0].username!
        print(desiredAccounts)
        print(desiredImages)
        
        setupCollectionView()
    }
    
    var incomingText : Post?
    
    
    
    
    

    @IBOutlet weak var lblPlaceName: UILabel!
    
    
    @IBOutlet weak var lblPostedByName: UILabel!
    
    
    
    
}

//cell.lblPlacePicture.image = UIImage(data: desiredTableCellImage[0].placeImage!)


extension DynamicPostInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return desiredImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! PostCollectionViewCell
//        let imageName  = desiredImages[indexPath.item].placeImage!
        let image = UIImage(data: desiredImages[indexPath.item].placeImage!) ?? UIImage()
        cell.configure(image: image)
        cell.clipsToBounds = true
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
