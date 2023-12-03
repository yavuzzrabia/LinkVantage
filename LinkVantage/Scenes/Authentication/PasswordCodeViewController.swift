//
//  PasswordCodeViewController.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 27.11.2023.
//

import UIKit

class PasswordCodeViewController: UIViewController {

    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func resendCodeAction(_ sender: Any) {
    }
    
    @IBAction func submitAction(_ sender: Any) {
        performSegue(withIdentifier: "toNewPassword", sender: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
