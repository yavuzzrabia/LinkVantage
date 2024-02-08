//
//  ViewController.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 8.11.2023.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.hasOnboarded {
            if Auth.auth().currentUser != nil {
                self.performSegue(withIdentifier: "toTabBar", sender: nil)
            } else {
                rootVC()
                self.performSegue(withIdentifier: "toAuthentication", sender: nil)
            }
        } else {
            self.performSegue(withIdentifier: "toOnboarding", sender: nil)
        }
    }
    
    func rootVC(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "loginPage") as! LoginViewController
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }

}

