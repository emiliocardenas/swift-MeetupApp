//
//  FeedViewController.swift
//  QatarMeetups
//
//  Created by Emilio Cardenas on 11/25/22.
//

import UIKit
import CoreData

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var desiredTableViewAccount = [Account] ()
    
    var desiredTableCellImage = [Images] ()


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DemoTableViewCell.nib(), forCellReuseIdentifier: DemoTableViewCell.identifier)

        
        //Refetch all post data
        do {
            postData = try context.fetch(Post.fetchRequest())
            
            for items in postData {
                print("Longitude:", items.longitude, "Latitude:", items.latitude)
            }
        }
        catch {}
    }
    
    
    // Table Funcs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //fetch proper table cell usernames
        do {
            let request = Account.fetchRequest() as NSFetchRequest<Account>
            // Filter to not re-enter existing email
            let pred = NSPredicate(format: "post == %@", postData[indexPath.row])
            request.predicate = pred
            desiredTableViewAccount = try context.fetch(request)
        }
        catch {}
        
        
        do {
            let imageRequest = Images.fetchRequest() as NSFetchRequest<Images>
            
            // Filter to not re-enter existing email
            let pred = NSPredicate(format: "post == %@", postData[indexPath.row])
            
            imageRequest.predicate = pred
            
            desiredTableCellImage = try context.fetch(imageRequest)
        }
        catch {}

        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DemoTableViewCell.identifier, for: indexPath) as! DemoTableViewCell
        cell.lblPlaceName.text = postData[indexPath.row].placeName!
        cell.lblUsername.text = "Posted by \(desiredTableViewAccount[0].username!)"
        cell.lblDateTime.text = "Post Date: \(postData[indexPath.row].date!)"
        cell.lblGame.text = "City: \(postData[indexPath.row].cityName!)"
        cell.lblAssistingNumber.text = postData[indexPath.row].rating!
        cell.lblPlacePicture.image = UIImage(data: desiredTableCellImage[0].placeImage!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "postInfo", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Refetch all post data
        do {
            postData = try context.fetch(Post.fetchRequest())
            
//            for items in postData {
//                print("Longitude:", items.longitude, "Latitude:", items.latitude)
//            }
        }
        catch {}
    }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DynamicPostInfoViewController {
            destination.incomingText = postData[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    @IBAction func btnAddNewPost(_ sender: UIButton) {
        performSegue(withIdentifier: "feedToNewPost", sender: self)
    }
    

    



}


