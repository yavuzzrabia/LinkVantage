//
//  UserPostsResponseModel.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 26.03.2024.
//

import Foundation
import Firebase

struct UserPostsResponseModel: Codable {
    var content: String
    var datePublished: Date
    var userID: DocumentReference
}
