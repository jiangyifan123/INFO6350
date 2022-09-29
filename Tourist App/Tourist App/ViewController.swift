//
//  ViewController.swift
//  Tourist App
//
//  Created by 江一帆 on 9/28/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let TouristPlacesNames = ["Mountain Rushmore", "Time Square", "Statue of Liberty"]
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TouristPlacesNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TouristCell", owner: self)?.first as! TouristCell
        cell.imgTourist.image = UIImage(named: TouristPlacesNames[indexPath.row])
        cell.lblTourist.text = TouristPlacesNames[indexPath.row]
        return cell
    }
    
}

