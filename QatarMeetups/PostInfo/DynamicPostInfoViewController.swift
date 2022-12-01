//
//  DynamicPostInfoViewController.swift
//  QatarMeetups
//
//  Created by Emilio Cardenas on 11/25/22.
//

import UIKit
import CoreData
import MapKit

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
        lblPostedByName.text = "\((desiredAccounts[0].username)!)"
        imgOtherAccount.image = UIImage(data: desiredAccounts[0].profilePicture!)
        lblRating.text = "\((incomingText?.rating)!)"
        lblDescription.text = "\((incomingText?.review)!)"
        lblCityName.text = "\((incomingText?.cityName)!)"
        
        imgOtherAccount.layer.cornerRadius = 20
        imgOtherAccount.clipsToBounds = true
        
        
        roundView.layer.cornerRadius = 10
        roundView.clipsToBounds = true

//        print(desiredAccounts)
//        print(desiredImages)
        
        setupCollectionView()
    }
    
    var incomingText : Post?
    
    @IBOutlet weak var roundView: UIView!
    

    @IBOutlet weak var lblPlaceName: UILabel!
    
    
    @IBOutlet weak var imgOtherAccount: UIImageView!
    
    @IBOutlet weak var lblPostedByName: UILabel!
    
    
    @IBOutlet weak var lblCityName: UILabel!
    
    
    @IBOutlet weak var lblRating: UILabel!
    
    
    @IBOutlet weak var lblDescription: UITextView!
    
    
    
    
    @IBAction func btnOpenInMaps(_ sender: UIButton) {
        
        let latitudeStringToDouble : Double = Double("\((incomingText?.latitude)!)")!
        let longitudeStringToDouble : Double = Double("\((incomingText?.longitude)!)")!

        
        print(latitudeStringToDouble)
        
        let latitude: CLLocationDegrees = latitudeStringToDouble
        let longitude: CLLocationDegrees = longitudeStringToDouble
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\((incomingText?.placeName)!)"
        mapItem.openInMaps(launchOptions: options)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? OtherAccounrViewController {
            destination.otherAccount = desiredAccounts[0]
        }
    }
    
    
    @IBAction func btnSeeProfile(_ sender: UIButton) {
        performSegue(withIdentifier: "seeProfile", sender: self)
    }
    
    
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
