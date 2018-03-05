//
//  MyUser.swift
//  VibeDating
//
//  Created by Andrew Foghel on 3/3/18.
//  Copyright © 2018 andrewfoghel. All rights reserved.
//

import Foundation

class MyUser: NSObject {
    var uid: String?
    var name: String?
    var email: String?
    var profileImageUrl: String?
    
    convenience init(uid: String, name: String, email: String, profileImageUrl: String) {
        self.init()
        self.uid = uid
        self.name = name
        self.email = email
        self.profileImageUrl = profileImageUrl
    }
    
    convenience init(key: String, dictionary: [String : Any]) {
        self.init()
        self.uid = key
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
    
    var asJSON: [String : Any] {
        return ["name" : self.name ?? "", "email" : self.email ?? "", "profileImageUrl" : self.profileImageUrl ?? ""]
    }
    
    
}
