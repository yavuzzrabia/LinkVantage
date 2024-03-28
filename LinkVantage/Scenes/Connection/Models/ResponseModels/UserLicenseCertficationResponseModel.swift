//
//  UserLicenseCertificationResponseModel.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 28.03.2024.
//

import Foundation
import Firebase

struct UserLicenseCertficationResponseModel: Codable {
    var userID: DocumentReference
    var name: String
    var company: String
    var link: String
    var dateIssued: Date
//    var image: DocumentReference
}

