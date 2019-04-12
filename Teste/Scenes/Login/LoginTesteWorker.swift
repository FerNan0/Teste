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
        case login = "https://bank-app-test.herokuapp.com/api/login"
}

protocol Calls {
    func callLogin(user: String, password: String, completion: @escaping (Response) -> Void)
}

class LoginTesteWorker: Calls
{
    func callLogin(user: String, password: String, completion: @escaping (Response) -> Void)
    {
        Alamofire.request(url.login.rawValue, method: .post, parameters: ["user" : user, "password" : password], encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: { response in
            let jsonResponse = Response(dictionary: response.result.value as! NSDictionary)            
            print(jsonResponse)
            completion(jsonResponse)
        })
    }
}
