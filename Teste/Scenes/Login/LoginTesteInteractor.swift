//
//  LoginTesteInteractor.swift
//  Teste
//
//  Created by Fernando Duarte on 10/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

protocol LoginProtocol {
    func validateLogin(password: String, user: String)
    func clickLogout()
}

protocol LoginDataStore
{
    var user: UserAccount? { get set }
}
class LoginTesteInteractor: LoginProtocol, LoginDataStore {
    var user: UserAccount?    
    var worker: CallsLogin?
    var presenter: ResponseLoginProtocol?
    
    func validateLogin(password: String, user: String) {
        let up = password.rangeOfCharacter(from: CharacterSet.uppercaseLetters) != nil
        let regex = ".*[^A-Za-z0-9].*"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        let spe = testString.evaluate(with: password)
        let alpha = password.rangeOfCharacter(from: CharacterSet.alphanumerics) != nil
        let passwordBool =  up && spe && alpha
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        if !passwordBool {
            presenter?.invalidLogin(isUserInvalid: false)
        } else if !(emailPredicate.evaluate(with: user) || user.isCPFValid()) {
            presenter?.invalidLogin(isUserInvalid: true)
        } else {
            loginValid(user: user, password: password)
        }
    }
    
    func clickLogout() {
        
    }
    
    func loginValid(user: String, password: String) {
        worker?.callLogin(user: user, password: password, completion: { response in
            self.presenter?.responseLogin(response: response)
            self.fetchLogin(response: response)
        })
    }
    
    func fetchLogin(response: ResponseLogin)
    {
        self.user = response.userAccount
    }
}
