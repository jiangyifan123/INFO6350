//
//  ViewController.swift
//  Weather forecast
//
//  Created by 江一帆 on 11/19/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var txtCity: UITextField!
    
    var posts:[String] = [String]()
    
    let locationManager = CLLocationManager()
    var lat: CLLocationDegrees?
    var lng: CLLocationDegrees?

    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        lat = location.coordinate.latitude
        lng = location.coordinate.longitude
        
        print(lat)
        print(lng)
        
        
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    @IBAction func getLocationAction(_ sender: Any){
        guard let city = txtCity.text else {return}
        let str = "\(lat!),\(lng!)"
        let api_key = "AYQR6QM5KHFYVPH9M4EXXJUCC"
        let url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast?locations=\(str)&aggregateHours=24&unitGroup=us&shortColumnNames=false&contentType=json&key=\(api_key)"

        print("url: \(url)")
        SwiftSpinner.show("please wait")
        
        self.posts = [String]()
        AF.request(url).responseJSON { responseData in
            //print(responseData)
            SwiftSpinner.hide()
            if responseData.error != nil {
                print(responseData.error!)
                return

            }
            let weatherData = JSON(responseData.data as Any)

            let forecastValues =  weatherData["locations"][str]["values"]
            print(forecastValues.count)
            for forecast in forecastValues {
                let forecastJSON = JSON(forecast.1)
                let temp = forecastJSON["temp"].floatValue
                let condition = forecastJSON["conditions"].stringValue
                self.posts.append("temperature:\(temp)F,\(condition)")
            }
            self.tblView.reloadData()
        }
        
    }
    
    @IBAction func getWeatherAction(_ sender: Any) {
        guard let city = txtCity.text else {return}
        let changeCity = city.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        let api_key = "AYQR6QM5KHFYVPH9M4EXXJUCC"
        let url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast?locations=\(changeCity)&aggregateHours=24&unitGroup=us&shortColumnNames=false&contentType=json&key=\(api_key)"

        print("url: \(url)")
        SwiftSpinner.show("please wait")
        
        self.posts = [String]()
        AF.request(url).responseJSON { responseData in
            //print(responseData)
            SwiftSpinner.hide()
            if responseData.error != nil {
                print(responseData.error!)
                return

            }
            let weatherData = JSON(responseData.data as Any)

            let forecastValues =  weatherData["locations"][changeCity]["values"]
            print(forecastValues.count)
            for forecast in forecastValues {
                let forecastJSON = JSON(forecast.1)
                let temp = forecastJSON["temp"].floatValue
                let condition = forecastJSON["conditions"].stringValue
                self.posts.append("temperature:\(temp)F,\(condition)")
            }
            self.tblView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("WeatherTableViewCell", owner: self)?.first as! WeatherTableViewCell
        
        cell.temperature.text = posts[indexPath.row]
        return cell
    }
}

