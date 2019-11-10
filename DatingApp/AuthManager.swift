//
//  AuthManager.swift
//  DatingApp
//
//  Created by Taku Funakoshi on 2019/11/09.
//  Copyright © 2019 Taku Funakoshi. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthManager {
    func isLogin() -> Bool {
        let user = Auth.auth().currentUser
        if user != nil {
            return true
        }else{
            return false
        }
    }
}
