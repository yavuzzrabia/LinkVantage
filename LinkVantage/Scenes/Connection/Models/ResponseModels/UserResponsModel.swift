//
//  UserResponsModel.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 29.02.2024.
//

import Foundation
import Firebase

struct UserResponsModel: Codable {
    var name: String
    var surname: String
    var email: String
    var occupation: String
    var about: String
    var profileImageRef: DocumentReference
    var backgroundImageRef: DocumentReference
}
