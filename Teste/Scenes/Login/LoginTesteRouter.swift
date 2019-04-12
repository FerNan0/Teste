//
//  LoginTesteRouter.swift
//  Teste
//
//  Created by Fernando Duarte on 10/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

protocol LoginRouting {
    func routeToStatements()
}

class LoginTesteRouter : LoginRouting {
    weak var viewController: LoginTesteViewController?
    func routeToStatements() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "StatementsTesteViewController") as! StatementsTesteViewController
        viewController?.present(destinationVC, animated: true, completion: nil)
    }
}
