//
//  LoginTesteInteractor.swift
//  Teste
//
//  Created by Fernando Duarte on 10/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

protocol LoginProtocol {
    func clickLogin(user: String, password: String)
}

protocol LoginDataStore
{
    var user: UserAccount? { get set }
}
class LoginTesteInteractor: LoginProtocol, LoginDataStore {
    var user: UserAccount?    
    var worker: Calls?
    var presenter: ResponseProtocol?
    
    func clickLogin(user: String, password: String) {
        worker?.callLogin(user: user, password: password, completion: { response in
            self.presenter?.responseLogin(response: response)
            self.fetchOrders(response: response)
        })
    }
    
    func fetchOrders(response: Response)
    {
        self.user = response.userAccount
    }
}
