//
//  ProfileViewController.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 9.02.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var userID: String?

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    @IBOutlet weak var activityTableView: UITableView!
    @IBOutlet weak var experienceTableView: UITableView!
    @IBOutlet weak var educationTableView: UITableView!
    @IBOutlet weak var licenseCertficationTableView: UITableView!
    @IBOutlet weak var volunteeringTableView: UITableView!
    @IBOutlet weak var skillTableView: UITableView!
    
    @IBOutlet weak var createPostButton: UIButton!
    @IBOutlet weak var showAllPostsButton: UIButton!
    @IBOutlet weak var showAllExperiencesButton: UIButton!
    @IBOutlet weak var showAllEducationsButton: UIButton!
    @IBOutlet weak var showAllLicensesCertficationsButton: UIButton!
    @IBOutlet weak var showAllVolunteeringButton: UIButton!
    @IBOutlet weak var showAllSkillsButton: UIButton!
    
    @IBOutlet weak var aboutHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var experienceHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var educationHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var licenseCertficationHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var volunteeringHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var skillHeightconstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func settingBackgroundImage(_ sender: Any) {
    }
    @IBAction func settinPersonalInformation(_ sender: Any) {
    }
    @IBAction func settingAbout(_ sender: Any) {
    }
    @IBAction func settingPost(_ sender: Any) {
    }
    @IBAction func createPostButton(_ sender: Any) {
    }
    @IBAction func showAllPosts(_ sender: Any) {
    }
    @IBAction func settingExperience(_ sender: Any) {
    }
    @IBAction func addExperience(_ sender: Any) {
    }
    @IBAction func showAllExperiences(_ sender: Any) {
    }
    @IBAction func settingEducation(_ sender: Any) {
    }
    @IBAction func addEducation(_ sender: Any) {
    }
    @IBAction func showAllEducations(_ sender: Any) {
    }
    @IBAction func settingLicenseCertfication(_ sender: Any) {
    }
    @IBAction func addLicenseCertfication(_ sender: Any) {
    }
    @IBAction func showAllLicensesCertfications(_ sender: Any) {
    }
    @IBAction func settingVolunteering(_ sender: Any) {
    }
    @IBAction func addVolunteering(_ sender: Any) {
    }
    @IBAction func showAllVolunteering(_ sender: Any) {
    }
    @IBAction func settingSkill(_ sender: Any) {
    }
    @IBAction func addSkill(_ sender: Any) {
    }
    @IBAction func showAllSkills(_ sender: Any) {
    }
    
}
