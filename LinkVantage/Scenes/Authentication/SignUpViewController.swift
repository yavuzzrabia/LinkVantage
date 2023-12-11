//
//  SignUpViewController.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 27.11.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var againPasswordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        nameTextField.delegate = self
        surnameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        againPasswordTextField.delegate = self
        nameTextField.setFieldType(textField: nameTextField, type: .nameTextField, returnKeyType: .next, tag: 0)
        surnameTextField.setFieldType(textField: surnameTextField, type: .surnameTextField, returnKeyType: .next, tag: 1)
        emailTextField.setFieldType(textField: emailTextField, type: .emailTextField, returnKeyType: .next, tag: 2)
        passwordTextField.setFieldType(textField: passwordTextField, type: .passwordTextField, returnKeyType: .next, tag: 3)
        againPasswordTextField.setFieldType(textField: againPasswordTextField, type: .againPasswordTextField, returnKeyType: .done, tag: 4)
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
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else { return }
          guard let user = result?.user, let idToken = user.idToken?.tokenString else { return }
          let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
              // At this point, our user is signed in
                self.rootVC()
            }
        }
    }
    
    func errorAlert(){
        let alert = UIAlertController(title: "Error", message: "Please fill in the blank fields to register.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            textField.resignFirstResponder()
            surnameTextField.becomeFirstResponder()
        } else if textField == surnameTextField {
            textField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            againPasswordTextField.becomeFirstResponder()
        } else if textField == againPasswordTextField {
            textField.resignFirstResponder()
            view.endEditing(true)
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func rootVC() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }

}
