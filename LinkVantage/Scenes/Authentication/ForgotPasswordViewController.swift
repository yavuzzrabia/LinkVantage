//
//  ForgotPasswordViewController.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 27.11.2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func nextAction(_ sender: Any) {
        performSegue(withIdentifier: "toCodePage", sender: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
