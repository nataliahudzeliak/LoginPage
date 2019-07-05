//
//  UserInfoManager.swift
//  LoginPage
//
//  Created by Family on 7/4/19.
//  Copyright © 2019 Family. All rights reserved.
//

import Foundation

class UserInfoManager {
    
    private static var _sharedInstance: UserInfoManager! = UserInfoManager()
    
    class func sharedInstance() -> UserInfoManager {
        if _sharedInstance == nil {
            _sharedInstance = UserInfoManager()
        }
        return _sharedInstance
    }
    var currentUser: User? 
}
