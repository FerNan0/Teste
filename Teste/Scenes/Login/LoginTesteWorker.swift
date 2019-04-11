//
//  LoginTesteWorker.swift
//  Teste
//
//  Created by Fernando Duarte on 11/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit
import Alamofire

enum url: String {
        case login = "https://bank-app-test.herokuapp.com/api/login "
}

protocol calls {
    func callLogin(user: String, password: String)
}

class LoginTesteWorker: calls
{
    func callLogin(user: String, password: String)
    {
        Alamofire.request(url.login.rawValue, method: .post, parameters: ["user" : user, "password" : password], encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {response in 
                let jsonResponse = response.result.value as! NSDictionary
                print(jsonResponse)
            })
    }
}
