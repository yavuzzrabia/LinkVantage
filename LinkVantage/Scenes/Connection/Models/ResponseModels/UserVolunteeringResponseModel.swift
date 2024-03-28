//
//  UserVolunteeringResponseModel.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 28.03.2024.
//

import Foundation
import Firebase

struct UserVolunteeringResponseModel: Codable {
    var userID: DocumentReference
    var organization: String
    var role: String
    var dateStart: Date
    var dateEnd: Date
//    var image: DocumentReference
}
