//
//  UserEntity.swift
//  LoginPage
//
//  Created by Family on 7/5/19.
//  Copyright © 2019 Family. All rights reserved.
//

import Foundation
import RealmSwift

class UserEntity: Object {
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var password: String = ""
}
