//
//  ForgotPasswordViewController.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 27.11.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        emailTextField.setFieldType(textField: emailTextField, type: .emailTextField, returnKeyType: .done, tag: 0)
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func nextAction(_ sender: Any) {
        guard let email = self.emailTextField.text, !email.isEmpty, email.isEmailAddress else {
            let alert = UIAlertController(title: "Error", message: "Please enter your e-mail address.", preferredStyle:UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error {
                debugPrint("Could not send password reset request: \(error.localizedDescription).")
            } else {
                debugPrint("Password reset code has been sent.")
                let alert = UIAlertController(title: nil, message: "The password reset link has been sent to your e-mail address. You can reset your password by clicking the link in your e-mail address.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default){ _ in
                    self.dismiss(animated: true)
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            nextAction(self)
        }
        return true
    }
    
}
