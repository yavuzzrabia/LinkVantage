//
//  ViewController.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 8.11.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "toOnboarding", sender: nil)
//        self.performSegue(withIdentifier: "toAuthentication", sender: nil)
    }

}

