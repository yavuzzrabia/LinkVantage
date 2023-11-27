//
//  OnboardingViewController.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 8.11.2023.
//

import UIKit

struct OnboardingPage {
    let imageName: String
    let title: String
}

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    let onboardingPages: [OnboardingPage] = [
        OnboardingPage(imageName: "onboarding1", title: "Find and land your next job"),
        OnboardingPage(imageName: "onboarding2", title: "Build your network on the go"),
        OnboardingPage(imageName: "onboarding3", title: "Stay ahead with curated content for your career")
    ]
    var currentPage = 0 {
        didSet {
            pageController.currentPage = currentPage
            setupPage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageController.numberOfPages = onboardingPages.count
        imageView.contentMode = .scaleAspectFit
        setupPage()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        if currentPage == onboardingPages.count - 1 {
            self.pushLogin()
        } else {
            currentPage += 1
        }
    }
    
    @IBAction func skipAction(_ sender: Any) {
        self.pushLogin()
    }
    
    func pushLogin() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Authentication", bundle:nil)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "loginPage") as! LoginViewController
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func setupPage() {
        imageView.image = UIImage(named: onboardingPages[currentPage].imageName)
        titleLabel.text = onboardingPages[currentPage].title
    }

}

