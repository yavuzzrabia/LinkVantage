//
//  LoginViewController.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 9.11.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

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
        emailTextField.setFieldType(textField: emailTextField, type: .emailTextField, returnKeyType: .next, tag: 0)
        passwordTextField.setFieldType(textField: passwordTextField, type: .passwordTextField, returnKeyType: .go, tag: 1)
        signinWithAppleButton.layer.borderColor = CGColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        signinWithAppleButton.layer.borderWidth = 1
        signinWithAppleButton.layer.cornerRadius = 20
        signinWithGoogleButton.layer.borderColor = CGColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        signinWithGoogleButton.layer.borderWidth = 1
        signinWithGoogleButton.layer.cornerRadius = 20
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
    
}

extension LoginViewController {
    
    func rootVC() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            signinAction(self)
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
