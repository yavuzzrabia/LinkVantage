//
//  TabBarController.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 3.12.2023.
//

import UIKit

enum TabIndex: Int {
    case home = 0
    case myNetwork
    case post
    case notifications
    case jobs
}

class TabBarController: UITabBarController {

    var tabIndex: TabIndex = .home {
        didSet {
            self.selectedIndex = self.tabIndex.rawValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
