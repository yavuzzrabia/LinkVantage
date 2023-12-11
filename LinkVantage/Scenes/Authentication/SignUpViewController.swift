//
//  SignUpViewController.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 27.11.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var againPasswordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func signupAction(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else { errorAlert(); return }
        guard let surname = surnameTextField.text, !surname.isEmpty else { errorAlert(); return }
        guard let email = emailTextField.text, !email.isEmpty, email.isEmailAddress else { errorAlert(); return }
        guard let password = passwordTextField.text, !password.isEmpty else { errorAlert(); return }
        guard let againPassword = againPasswordTextField.text, !againPassword.isEmpty else { errorAlert(); return }
        if password == againPassword {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: "Registration could not be completed.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: nil, message: "Registration has been completed successfully.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                        self.dismiss(animated: true)
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "The entered passwords do not match.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func signupWithGoogleAction(_ sender: Any) {
    }
    
    func errorAlert(){
        let alert = UIAlertController(title: "Error", message: "Please fill in the blank fields to register.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    

}
