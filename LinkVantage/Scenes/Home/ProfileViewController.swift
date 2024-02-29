//
//  ProfileViewController.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 9.02.2024.
//

import UIKit
import Firebase
import FirebaseStorage

class ProfileViewController: UIViewController {
    
    var userID: String? = "xnALn5QFPlJB9rTlVAJD"
    var user: UserResponsModel?
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
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
        getUserInfo()
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
    
    func getUserInfo(){
        guard let userID = userID else { return }
        db.collection("users").document(userID).getDocument { documentSnapshot, error in
            if let document = documentSnapshot, document.exists {
                do {
                    self.user = try document.data(as: UserResponsModel.self)
                    guard let name = self.user?.name, let surname = self.user?.surname else { return }
                    self.nameSurnameLabel.text = name + " " + surname
                    guard let occupation = self.user?.occupation else { return }
                    self.occupationLabel.text = occupation
                    guard let about = self.user?.about else { return }
                    self.aboutLabel.text = about
                    guard let profileImageID = self.user?.profileImageRef.documentID, let backgroundImageID = self.user?.backgroundImageRef.documentID else { return }
                    let profileImageRef = self.storage.reference(withPath: "profile/\(profileImageID)")
                    let backgroundImageRef = self.storage.reference(withPath: "background/\(backgroundImageID)")
                    profileImageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                      if let error = error {
                          print("Error getting profile image data: \(error)")
                      } else {
                          self.profileImage.image = UIImage(data: data!)
                      }
                    }
                    backgroundImageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                      if let error = error {
                          print("Error getting background image data: \(error)")
                      } else {
                          self.backgroundImage.image = UIImage(data: data!)
                      }
                    }
                } catch {
                    print("Error getting document: \(error)")
                }
            }
        }
    }
    
}
