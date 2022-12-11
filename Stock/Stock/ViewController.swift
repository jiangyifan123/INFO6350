//
//  ViewController.swift
//  Stock
//
//  Created by 江一帆 on 12/10/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    
    var stocks:[Stock] = [Stock]()
    var clickIdex = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        getStocks()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = stocks[indexPath.row].companyName
        return cell
    }
    
    func getStocks() {
        let url = "https://us-central1-whatsapp-analytics-2de0e.cloudfunctions.net/app/allstocks"

        SwiftSpinner.show("please wait")
        
        self.stocks = [Stock]()
        AF.request(url).responseJSON { responseData in
            SwiftSpinner.hide()
            print(responseData)
            if responseData.error != nil {
                print(responseData.error!)
                return
            }
            let stockData = JSON(responseData.data as Any)

            for stock in stockData{
                let stockJSON = JSON(stock.1)
                let companyName = stockJSON["CompanyName"].stringValue
                let Price = stockJSON["Price"].stringValue
                let Symbol = stockJSON["Symbol"].stringValue
                self.stocks.append(Stock(companyName: companyName, symbol: Symbol, price: Price))
            }
            self.tblView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.clickIdex = indexPath.row
        performSegue(withIdentifier: "segueDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetails" {
            let secondVC = segue.destination as! DetailsViewController
            let stock = stocks[clickIdex]
            secondVC.symbol = stock.symbol
        }
    }
}

