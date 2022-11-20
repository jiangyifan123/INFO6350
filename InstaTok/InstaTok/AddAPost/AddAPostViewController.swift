//
//  AddAPostViewController.swift
//  InstaTok
//
//  Created by 江一帆 on 11/17/22.
//

import UIKit
import CoreLocation
import FirebaseAuth
import FirebaseFirestore

class AddAPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var txtCaption: UITextField!
    
    let locationManager = CLLocationManager()
    
    var addressText = ""
    var db: Firestore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestLocation()
        db = Firestore.firestore()
    }

    @IBAction func selectImageAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Take a Picture", message: "Awesome Picture", preferredStyle: .alert)
                
        let cameraAction = UIAlertAction(title: "Camera", style: .default){ action in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true)
            }
            
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default){ action in
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ action in
            print("cancel Pressed")
        }
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgView.image = image
            
        }
        
        picker.dismiss(animated: true)
        
    }
    
    @IBAction func postAction(_ sender: Any) {
        guard let caption = txtCaption.text else {return}
        let imageURL = "SomeImageURL"
        let timeStamp = NSDate().timeIntervalSince1970
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard let db = db else {return}
        let path = "Posts";
        db.collection(path).addDocument(data: [
            "Caption": caption,
            "ImageURL": imageURL,
            "Timestamp": timeStamp,
            "Location": addressText,
            "UID": uid
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            }
            else {
                print("Document added successfully")
            }
        }

    }
}

extension AddAPostViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let lat = location.coordinate.latitude
        let lng = location.coordinate.longitude
        
        print(lat)
        print(lng)
        
        getAddressFromLocation(location: location)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func getAddressFromLocation( location: CLLocation){
        
        let clGeoCoder = CLGeocoder()
        
        clGeoCoder.reverseGeocodeLocation(location) { placeMarks, error in
            
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            var address = ""
            guard let place = placeMarks?.first else { return }
            
            if place.name != nil {
                address += place.name! +  ", "
            }
            
            if place.locality != nil {
                address += place.locality! +  ", "
            }
            
            if place.subLocality != nil {
                address += place.subLocality! +  ", "
            }
            
            if place.postalCode != nil {
                address += place.postalCode! +  ", "
            }
            
            if place.country != nil {
                address += place.country!
            }
            
            print(address)
            self.addressText = address
            
        }
    }
}
