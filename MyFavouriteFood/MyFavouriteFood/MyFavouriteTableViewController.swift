//
//  MyFavouriteTableViewController.swift
//  MyFavouriteFood
//
//  Created by 江一帆 on 9/21/22.
//

import UIKit

class MyFavouriteTableViewController: UITableViewController {

    let foodList = ["cheeseburger", "sandwich", "hot dog", "toast", "fries"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = foodList[indexPath.row]

        return cell
    }

}
