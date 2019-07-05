//
//  User.swift
//  LoginPage
//
//  Created by Family on 7/4/19.
//  Copyright © 2019 Family. All rights reserved.
//

import Foundation
struct userData : Codable {
    let data: User
}
struct User: Codable {
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "avatar"
     
    }
}


