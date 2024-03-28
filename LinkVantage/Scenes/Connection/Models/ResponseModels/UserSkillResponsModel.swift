//
//  UserSkillResponsModel.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 28.03.2024.
//

import Foundation
import Firebase

struct UserSkillResponsModel: Codable {
    var skill: String
    var userID: DocumentReference
}
