//
//  LoginTesteInteractor.swift
//  Teste
//
//  Created by Fernando Duarte on 10/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

protocol loginProtocol {
    func clickLogin(user: String, password: String)
}

class LoginTesteInteractor: loginProtocol {
    var worker: LoginTesteWorker?
    
    func clickLogin(user: String, password: String) {
        worker?.callLogin(user: user, password: password)
    }
}
