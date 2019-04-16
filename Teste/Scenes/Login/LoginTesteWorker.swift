//
//  LoginTesteWorker.swift
//  Teste
//
//  Created by Fernando Duarte on 11/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit
import Alamofire

enum urlLogin: String {
        case login = "https://bank-app-test.herokuapp.com/api/login"
}

protocol CallsLogin {
    func callLogin(user: String, password: String, completion: @escaping (ResponseLogin) -> Void)
}

class LoginTesteWorker: CallsLogin
{
    func callLogin(user: String, password: String, completion: @escaping (ResponseLogin) -> Void)
    {
        Alamofire.request(urlLogin.login.rawValue, method: .post, parameters: ["user" : user, "password" : password], encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: { response in
            let jsonResponse = ResponseLogin(dictionary: response.result.value as! NSDictionary)            
            print(jsonResponse)
            completion(jsonResponse)
        })
    }
}
