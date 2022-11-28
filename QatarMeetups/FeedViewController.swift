//
//  FeedViewController.swift
//  QatarMeetups
//
//  Created by Emilio Cardenas on 11/25/22.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let myData = ["Cosmic Caffe", "The Irish Pub Doha", "Champions Sports Bar", "fourth", "last"]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        tableView.register(DemoTableViewCell.nib(), forCellReuseIdentifier: DemoTableViewCell.identifier)

        // Do any additional setup after loading the view.
    }
    
    
    // Table Funcs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DemoTableViewCell.identifier, for: indexPath) as! DemoTableViewCell
        cell.lblPlaceName.text = myData[indexPath.row]
        cell.lblUsername.text = "Posted by John Smith"
        cell.lblDateTime.text = "11/26/22 at 10:00PM"
        cell.lblGame.text = "Argentina vs. Mexico"
        cell.lblAssistingNumber.text = "5"
        cell.lblPlacePicture.image = UIImage(named: "psg")       
        return cell
    }
    
    

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "postInfo", sender: self)
    }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DynamicPostInfoViewController {
            destination.incomingText = myData[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    



}


