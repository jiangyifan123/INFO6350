//
//  DetailsViewController.swift
//  Stock
//
//  Created by 江一帆 on 12/10/22.
//

import UIKit
import SwiftyJSON
import SwiftSpinner
import Alamofire

class DetailsViewController: UIViewController {

    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSymbol: UILabel!
    
    
    var symbol: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStocks()
    }

    
    func getStocks() {
        let url = "https://us-central1-whatsapp-analytics-2de0e.cloudfunctions.net/app/getstock?symbol=\(self.symbol)"

        SwiftSpinner.show("please wait")
        
        AF.request(url).responseJSON { responseData in
            SwiftSpinner.hide()
            print(responseData)
            if responseData.error != nil {
                print(responseData.error!)
                return
            }
            let stockData = JSON(responseData.data as Any)

            self.lblPrice.text = "Price: \(stockData["Price"].stringValue)"
            self.lblCompanyName.text = "CompanyName: \(stockData["CompanyName"].stringValue)"
            self.lblSymbol.text = "Symbol: \(stockData["Symbol"].stringValue)"
        }
    }
}
