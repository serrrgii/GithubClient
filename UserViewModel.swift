//
//  UserViewModel.swift
//  GithubSwift
//
//  Created by Sergi Borras on 04/10/15.
//  Copyright © 2015 Sergi Borras. All rights reserved.
//

import Foundation

enum ResultType<T, U> {
    case Success(r: T)
    case Error(e: U)
}

struct UserViewModel {
    
    enum ModelViewError: ErrorType {
        case RequestError
        case SerializationError
    }
    
    private var user: User?
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var loginText = ""
    var nameText = ""
    var avatarURLText = ""
    
    init(user: User?) {
        self.user = user
    }
    
    init() {}
    
    private func createUserFromData(data: NSData) throws -> User {
        
        var userDictionary: AnyObject?
        
        do {
            userDictionary = try NSJSONSerialization.JSONObjectWithData(data,
                options: .AllowFragments)
        } catch _  {
            throw ModelViewError.SerializationError
        }
        
        guard let theUserDictionary = userDictionary as? Dictionary<String, AnyObject> else {
            throw ModelViewError.SerializationError
        }
        
        return User(from: theUserDictionary)
    }

    mutating func findUserWithLogin(login: String, completionHandler: ResultType<UserViewModel, ModelViewError> -> Void) {
        let urlString = "https://api.github.com/users/\(login)"
        let url = NSURL(string: urlString)
        if let theURL = url {
            let dataTask = session.dataTaskWithURL(theURL, completionHandler: { data, response, error in
                
                guard error == nil else {
                    return completionHandler(ResultType.Error(e: ModelViewError.RequestError))
                }
                
                do {
                    let user = try self.createUserFromData(data!)
                    self.user = user
                    self.nameText = user.name
                    self.loginText = user.login
                    self.avatarURLText = user.avatarURLString
                    return completionHandler(ResultType.Success(r: self))
                }
                catch  {
                    return completionHandler(ResultType.Error(e: ModelViewError.SerializationError))
                }
            })
            dataTask.resume()
        }
    }
}