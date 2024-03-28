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
    var posts: [UserPostsResponseModel] = []
    var experiences: [UserExperiencesResponseModel] = []
    var educations: [UserEducationResponseModel] = []
    var certfications: [UserLicenseCertficationResponseModel] = []
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
        activityTableView.delegate = self
        activityTableView.dataSource = self
        getUserPosts{ [weak self] posts in
            self?.posts = posts
            self?.activityTableView.reloadData()
        }
        experienceTableView.delegate = self
        experienceTableView.dataSource = self
        getUserExperiences{ [weak self] experiences in
            self?.experiences = experiences
            self?.experienceTableView.reloadData()
        }
        educationTableView.delegate = self
        educationTableView.dataSource = self
        getUserEducations{ [weak self] educations in
            self?.educations = educations
            self?.educationTableView.reloadData()
        }
        licenseCertficationTableView.delegate = self
        licenseCertficationTableView.dataSource = self
        getUserLicenseCertfications{ [weak self] certfications in
            self?.certfications = certfications
            self?.licenseCertficationTableView.reloadData()
        }
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
                          self.profileImage.contentMode = .scaleAspectFill
                      }
                    }
                    backgroundImageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                      if let error = error {
                          print("Error getting background image data: \(error)")
                      } else {
                          self.backgroundImage.image = UIImage(data: data!)
                          self.backgroundImage.contentMode = .scaleAspectFill
                      }
                    }
                } catch {
                    print("Error getting document: \(error)")
                }
            }
        }
    }
    
    func getUserPosts(completion: @escaping ([UserPostsResponseModel]) -> Void) {
        guard let userID = userID else { return }
        let userRef = db.collection("users").document(userID)
        db.collection("posts").whereField("userID", isEqualTo: userRef).getDocuments { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                if querySnapshot.documents.count != 0 {
                    for document in querySnapshot.documents {
                        do {
                            let post = try document.data(as: UserPostsResponseModel.self)
                            self.posts.append(post)
                        } catch {
                            print("Error getting document: \(error)")
                        }
                    }
                } else {
                    print("There is not querySnapshot.documents ")
                }
            }
            completion(self.posts)
        }
    }
    
    func getUserExperiences(completion: @escaping ([UserExperiencesResponseModel]) -> Void) {
        guard let userID = userID else { return }
        let userRef = db.collection("users").document(userID)
        db.collection("experiences").whereField("userID", isEqualTo: userRef).getDocuments { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                if querySnapshot.documents.count != 0 {
                    for document in querySnapshot.documents {
                        do {
                            let experience = try document.data(as: UserExperiencesResponseModel.self)
                            self.experiences.append(experience)
                        } catch {
                            print("Error getting document: \(error)")
                        }
                    }
                } else {
                    print("There is not querySnapshot.documents ")
                }
            }
            completion(self.experiences)
        }
    }
    
    func getUserEducations(completion: @escaping ([UserEducationResponseModel]) -> Void) {
        guard let userID = userID else { return }
        let userRef = db.collection("users").document(userID)
        db.collection("educations").whereField("userID", isEqualTo: userRef).getDocuments { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                if querySnapshot.documents.count != 0 {
                    for document in querySnapshot.documents {
                        do {
                            let education = try document.data(as: UserEducationResponseModel.self)
                            self.educations.append(education)
                        } catch {
                            print("Error getting document: \(error)")
                        }
                    }
                } else {
                    print("There is not querySnapshot.documents ")
                }
            }
            completion(self.educations)
        }
    }
    
    func getUserLicenseCertfications(completion: @escaping ([UserLicenseCertficationResponseModel]) -> Void){
        guard let userID = userID else { return }
        let userRef = db.collection("users").document(userID)
        db.collection("licenses&certifications").whereField("userID", isEqualTo: userRef).getDocuments { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                if querySnapshot.documents.count != 0 {
                    for document in querySnapshot.documents {
                        do {
                            let certfication = try document.data(as: UserLicenseCertficationResponseModel.self)
                            self.certfications.append(certfication)
                        } catch {
                            print("Error getting document: \(error)")
                        }
                    }
                } else {
                    print("There is not querySnapshot.documents ")
                }
            }
            completion(self.certfications)
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == activityTableView {
            if posts.isEmpty {
                activityHeightConstraint.constant = 0
                return 0
            } else if posts.count == 1 {
                posts.sort { $0.datePublished > $1.datePublished }
                activityHeightConstraint.constant = 170
                return 1
            } else {
                posts.sort { $0.datePublished > $1.datePublished }
                activityHeightConstraint.constant = 270
                return 2
            }
        } else if tableView == experienceTableView {
            if experiences.isEmpty {
                experienceHeightConstraint.constant = 0
                return 0
            } else if experiences.count == 1 {
                experiences.sort { $0.dateStart > $1.dateStart }
                experienceHeightConstraint.constant = 170
                return 1
            } else {
                experiences.sort { $0.dateStart > $1.dateStart }
                experienceHeightConstraint.constant = 270
                return 2
            }
        } else if tableView == educationTableView {
            if educations.isEmpty {
                educationHeightConstraint.constant = 0
                return 0
            } else if educations.count == 1 {
                educations.sort { $0.dateStart > $1.dateStart }
                educationHeightConstraint.constant = 170
                return 1
            } else {
                educations.sort { $0.dateStart > $1.dateStart }
                educationHeightConstraint.constant = 270
               return 2
            }
        } else if tableView == licenseCertficationTableView {
            if certfications.isEmpty {
                licenseCertficationHeightConstraint.constant = 0
                return 0
            } else if certfications.count == 1 {
                certfications.sort { $0.dateIssued > $1.dateIssued }
                licenseCertficationHeightConstraint.constant = 170
                return 1
            } else {
                certfications.sort { $0.dateIssued > $1.dateIssued }
                licenseCertficationHeightConstraint.constant = 270
               return 2
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == activityTableView {
            let cell = Bundle.main.loadNibNamed("ActivityTableViewCell", owner: self, options: nil)?.first as! ActivityTableViewCell
            if !posts.isEmpty {
                cell.contentLabel.text = posts[indexPath.row].content
                cell.postImageView.image = UIImage(named: "apple")
            }
            return cell
        } else if tableView == experienceTableView {
            let cell = Bundle.main.loadNibNamed("ExperienceTableViewCell", owner: self, options: nil)?.first as! ExperienceTableViewCell
            if !experiences.isEmpty {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM.yyyy"
                let startDate = dateFormatter.string(from: experiences[indexPath.row].dateStart)
                let endDate = dateFormatter.string(from: experiences[indexPath.row].dateEnd)
                cell.companyNameLabel.text = experiences[indexPath.row].company
                cell.experienceImageView.image = UIImage(named: "apple")
                cell.timeLabel.text = "\(startDate) - \(endDate)"
            }
            return cell
        } else if tableView == educationTableView {
            let cell = Bundle.main.loadNibNamed("EducationTableViewCell", owner: self, options: nil)?.first as! EducationTableViewCell
            if !educations.isEmpty {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM.yyyy"
                let startDate = dateFormatter.string(from: educations[indexPath.row].dateStart)
                let endDate = dateFormatter.string(from: educations[indexPath.row].dateEnd)
                cell.schoolNameLabel.text = educations[indexPath.row].school
                cell.schoolDepartmentLabel.text = educations[indexPath.row].department
                cell.schoolImageView.image = UIImage(named: "apple")
                cell.timeLabel.text = "\(startDate) - \(endDate)"
            }
            return cell
        } else if tableView == licenseCertficationTableView {
            let cell = Bundle.main.loadNibNamed("LicenseCertficationTableViewCell", owner: self, options: nil)?.first as! LicenseCertficationTableViewCell
            if !certfications.isEmpty {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM.yyyy"
                let dateIssued = dateFormatter.string(from: certfications[indexPath.row].dateIssued)
                cell.nameLabel.text = certfications[indexPath.row].name
                cell.companyLabel.text = certfications[indexPath.row].company
                cell.dateLabel.text = dateIssued
                cell.companyImageView.image = UIImage(named: "apple")
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == activityTableView {
            return 100
        } else if tableView == experienceTableView {
            return 100
        } else if tableView == educationTableView {
            return 100
        } else if tableView == licenseCertficationTableView {
            return 100
        }
        return 0
    }
    
    
}
