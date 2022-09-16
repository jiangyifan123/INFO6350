//
//  ViewController.swift
//  Multiply Numbers
//
//  Created by 江一帆 on 9/14/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtFirstNumber: UITextField!
    @IBOutlet weak var txtSecondNumber: UITextField!
    @IBOutlet weak var lbResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func multiplyFunc(_ sender: Any) {
        let firstNumber: Double = Double(txtFirstNumber.text ?? "0") ?? 0
        let secondNumber: Double = Double(txtSecondNumber.text ?? "0") ?? 0
        let result = firstNumber * secondNumber
        lbResult.text = String(result)
    }
}

