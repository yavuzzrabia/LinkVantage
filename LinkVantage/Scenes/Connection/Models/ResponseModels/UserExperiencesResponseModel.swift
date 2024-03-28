//
//  UserExperiencesResponseModel.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 28.03.2024.
//

import Foundation
import Firebase

struct UserExperiencesResponseModel: Codable {
    var userID: DocumentReference
    var company: String
    var dateStart: Date
    var dateEnd: Date
//    var image: DocumentReference
}
