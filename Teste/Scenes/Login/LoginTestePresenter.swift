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
    func invalidLogin(isUserInvalid: Bool)
}

class LoginTestePresenter: ResponseLoginProtocol {
    
    var viewController: ValidateLoginResponseProtocol?
    
    func responseLogin(response: ResponseLogin) {
        if response.error?.code == nil {
            if let user = response.userAccount {
                viewController?.responseLoginValid(response: user)
            }
        } else {
            if let code = response.error?.code, let message = response.error?.message {
                viewController?.showAlert(title: String(format: "Error Code: %d", code), message: message, actionTitle: "OK")
            }
            
        }
    }

    func invalidLogin(isUserInvalid: Bool) {
        let title = "Something wrong"
        let confirmBtn = "OK"
        if isUserInvalid {
            viewController?.showAlert(title: title, message: "Invalid User", actionTitle: confirmBtn)
        } else {
            viewController?.showAlert(title: title, message: "Invalid Password", actionTitle: confirmBtn)
        }
    }
}
