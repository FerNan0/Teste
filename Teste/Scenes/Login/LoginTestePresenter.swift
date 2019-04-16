//
//  LoginTestePresenter.swift
//  Teste
//
//  Created by Fernando Duarte on 10/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

protocol ResponseLoginProtocol {
    func responseLogin(response: ResponseLogin)
}

class LoginTestePresenter: ResponseLoginProtocol {
    
    var viewController: ResponseLoginFromURLProtocol?
    
    func responseLogin(response: ResponseLogin) {
        if response.error?.code != nil {
            if let error = response.error {
                viewController?.responseLoginError(response: error)
            }
        } else {
            if let user = response.userAccount {
                viewController?.responseLoginValid(response: user)                
            }
        }
    }
}
