//
//  ViewController.swift
//  test
//
//  Created by 江一帆 on 12/10/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let food = ["1", "2"]
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.dataSource = self
        tblView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TestTableViewCell", owner: self)?.first as! TestTableViewCell
        cell.img.image = UIImage(named: food[indexPath.row])
        cell.txtName.text = food[indexPath.row]
        
        return cell
    }
}

