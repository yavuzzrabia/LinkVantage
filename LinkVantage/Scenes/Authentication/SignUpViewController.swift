//
//  SignUpViewController.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 27.11.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import GoogleSignIn

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    let db = Firestore.firestore()
    
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
        
        guard let name = nameTextField.text, !name.isEmpty else { errorAlert(message: "Please fill in the fields above correctly to register."); return }
        guard let surname = surnameTextField.text, !surname.isEmpty else { errorAlert(message: "Please fill in the fields above correctly to register."); return }
        guard let email = emailTextField.text, !email.isEmpty, email.isEmailAddress else { errorAlert(message: "Please fill in the fields above correctly to register."); return }
        guard let password = passwordTextField.text, !password.isEmpty else { errorAlert(message: "Please fill in the fields above correctly to register."); return }
        guard let againPassword = againPasswordTextField.text, !againPassword.isEmpty else { errorAlert(message: "Please fill in the fields above correctly to register."); return }
        
        if password == againPassword {
            if password.isStrongPassword {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if error != nil {
                        self.errorAlert(message: "Registration could not be completed.")
                    } else {
                        Task {
                            do {
                                let ref = try await self.db.collection("users").addDocument(data: [
                                    "name": name,
                                    "surname": surname,
                                    "email": email
                                ])
                                print("Document added with ID: \(ref.documentID)")
                                let alert = UIAlertController(title: nil, message: "Registration has been completed successfully.", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "OK", style: .default){_ in
                                    self.dismiss(animated: true)
                                }
                                alert.addAction(okAction)
                                self.present(alert, animated: true, completion: nil)
                            } catch {
                                self.errorAlert(message: "Registration could not be completed.")
                            }
                        }
                    }
                }
            } else {
                errorAlert(message: "Please check your password. Your password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character ($@$!%*?&).")
            }
        } else {
            self.errorAlert(message: "The entered passwords do not match.")
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
    
    func errorAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
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
