//
//  StatementsTesteRouter.swift
//  Teste
//
//  Created by Fernando Duarte on 12/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

protocol StatementsDataPassing
{
    var dataStore: StatementsDataStore? { get }
}

protocol LogoutProtocol {
    func goToLogin()
}

class StatementsTesteRouter: NSObject, StatementsDataPassing, LogoutProtocol {
    var dataStore: StatementsDataStore?
    var viewController: StatementsTesteViewController?
    
    func goToLogin() {
        let login = LoginTesteViewController(nibName: "LoginTesteViewController", bundle: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = login
    }
}
