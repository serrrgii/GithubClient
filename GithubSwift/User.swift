//
//  User.swift
//  GithubSwift
//
//  Created by Sergi Borras on 04/10/15.
//  Copyright © 2015 Sergi Borras. All rights reserved.
//

import Foundation


struct User {
    
    var login = ""
    var name = ""
    var avatarURLString = ""
    
    init(from dictionary: Dictionary<String, AnyObject>) {
        if let theName = dictionary["name"] as? String {
            self.name = theName
        }
        if let theLogin = dictionary["login"] as? String {
            self.login = theLogin
        }
        if let theAvatarURLString = dictionary["avatarURLString"] as? String {
            self.avatarURLString = theAvatarURLString
        }
    }
}


