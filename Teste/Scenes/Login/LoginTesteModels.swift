//
//  LoginTesteModels.swift
//  Teste
//
//  Created by Fernando Duarte on 11/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import Foundation

class UserAccount {
    var userId: Int = 0
    var name: String = ""
    var bankAccount: String = ""
    var agency: String = ""
    var balance: Double = 0.0
    
    public init(dictionary: NSDictionary) {
        self.userId = dictionary["userId"] as! Int
        self.name = dictionary["name"] as! String
        self.bankAccount = dictionary["bankAccount"] as! String
        self.agency = dictionary["agency"] as! String
        self.balance = dictionary["balance"] as! Double
    }
    
}
class Error {
    var code: Int?
    var message: String?
    public init(dictionary: NSDictionary) {
        self.code = dictionary["code"] as? Int
        self.message = dictionary["message"] as? String
    }
}

class Response {
    var userAccount: UserAccount?
    var error: Error?
    
    public init(dictionary: NSDictionary) {
        if let error = dictionary["error"] as? NSDictionary {
           self.error = Error(dictionary: error)
        } else {
            if let user = dictionary["UserAccount"] as? NSDictionary {
                self.userAccount = UserAccount(dictionary: user)
            }
        }
    }
}
