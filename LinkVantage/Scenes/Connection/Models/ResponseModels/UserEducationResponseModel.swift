//
//  UserEducationResponseModel.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 28.03.2024.
//

import Foundation
import Firebase

struct UserEducationResponseModel: Codable {
    var userID: DocumentReference
    var school: String
    var department: String
    var dateStart: Date
    var dateEnd: Date
//    var image: DocumentReference
}
