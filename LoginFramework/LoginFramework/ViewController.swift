//
//  ViewController.swift
//  LoginFramework
//
//  Created by 江一帆 on 11/18/22.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var txtemail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let keychain = KeyChainService().keyChain
        if keychain.get("uid") != nil {
            performSegue(withIdentifier: "segueDashboard", sender: self)
        }
        txtPassword.text = ""
    }
    
    func addUIDToKeyChain(_ uid: String){
        let keychain = KeyChainService().keyChain
        keychain.set(uid, forKey: "uid")
    }

    
    @IBAction func submitAction(_ sender: Any) {
        guard let email = txtemail.text else {return}
        guard let password = txtPassword.text else {return}
        print(email)
        print(password)
        if email.isEmail == false {
            self.txtStatus.isHidden = false
            self.txtStatus.text = "please input valid email"
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password){ [weak self] result, error in
            guard let strongSelf = self else {return}
            
            if error != nil {
                strongSelf.txtStatus.isHidden = false
                strongSelf.txtStatus.text = error?.localizedDescription
                return
            }
            
            guard let uid = Auth.auth().currentUser?.uid else {return}
            strongSelf.addUIDToKeyChain(uid)
            
            strongSelf.performSegue(withIdentifier: "segueDashboard", sender: strongSelf)
        }
    }
}

