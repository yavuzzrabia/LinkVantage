//
//  LoginViewController.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 9.11.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinWithAppleButton: UIButton!
    @IBOutlet weak var signinWithGoogleButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setFieldType(textField: emailTextField, type: .emailTextField, returnKeyType: .next, tag: 0)
        setFieldType(textField: passwordTextField, type: .passwordTextField, returnKeyType: .go, tag: 1)
        signinWithAppleButton.layer.borderColor = CGColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        signinWithAppleButton.layer.borderWidth = 1
        signinWithGoogleButton.layer.borderColor = CGColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        signinWithGoogleButton.layer.borderWidth = 1
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        performSegue(withIdentifier: "toForgotPassword", sender: nil)
    }
    
    @IBAction func signupAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignup", sender: nil)
    }
    
    @IBAction func signinAction(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password){ [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if error != nil {
                guard let error = error else { return }
                let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription) Please try again.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(okAction)
                strongSelf.present(alert, animated: true)
            } else {
                strongSelf.rootVC()
            }
        }
    }
    
    @IBAction func signinWithAppleAction(_ sender: Any) {
    }
    
    @IBAction func signinWithGoogleAction(_ sender: Any) {

    }
    
}

extension LoginViewController {
    
    func rootVC() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
}

//MARK: - TextField

extension LoginViewController {
    
    enum TextFieldTypes: String, CaseIterable {
        case nameTextField
        case surnameTextField
        case emailTextField
        case passwordTextField
        case passwordAgainTextField
    }
    
    func setFieldType(textField: UITextField ,type: TextFieldTypes, returnKeyType: UIReturnKeyType?, tag: Int?) {
        // set field tag
        if let receivedTag = tag {
            textField.tag = receivedTag
        }
        // set field return key type
        if let receivedReturnKeyType = returnKeyType {
            textField.returnKeyType = receivedReturnKeyType
        }
        // set field identifier
        textField.accessibilityIdentifier = String(describing: type)
        // set type
        switch type {
//        case .usernameTextField:
//            textField.placeholder = "Username"
//            textField.keyboardType = .default
//            textField.autocapitalizationType = .none
        case .nameTextField:
            textField.placeholder = "Name"
            textField.keyboardType = .default
            textField.autocapitalizationType = .words
        case .surnameTextField:
            textField.placeholder = "Surname"
            textField.keyboardType = .default
            textField.autocapitalizationType = .words
        case .emailTextField:
            textField.placeholder = "Email"
            textField.keyboardType = .emailAddress
            textField.autocapitalizationType = .none
        case .passwordTextField:
            textField.placeholder = "Password"
            textField.keyboardType = .default
            textField.autocapitalizationType = .none
            textField.isSecureTextEntry = true
        case .passwordAgainTextField:
            textField.placeholder = "Password again"
            textField.keyboardType = .default
            textField.autocapitalizationType = .none
            textField.isSecureTextEntry = true
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            signinAction(signinButton as UIButton)
        }
        return true
    }
    
}
