//
//  NewPasswordViewController.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 27.11.2023.
//

import UIKit

class NewPasswordViewController: UIViewController {

    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var againNewPasswordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func submitAction(_ sender: Any) {
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
