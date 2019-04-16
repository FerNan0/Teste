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
protocol LoginDataPassing
{
    var dataStore: LoginDataStore? { get }
}

class LoginTesteRouter : NSObject, LoginRouting, LoginDataPassing {
    var dataStore: LoginDataStore?
    
    weak var viewController: LoginTesteViewController?
    func routeToStatements() {
        let destinationVC: StatementsTesteViewController =  viewController?.storyboard?.instantiateViewController(withIdentifier: "StatementsTesteViewController") as! StatementsTesteViewController
        navigateToStatements(source: viewController!, destination: destinationVC)
    }
    
    func navigateToStatements(source: LoginTesteViewController, destination: StatementsTesteViewController)
    {
        source.show(destination, sender: nil)
        var destinationDS = destination.router?.dataStore        
        if let store = dataStore {
            passDataToStatements(source: store, destination: &destinationDS!)
        }
        
        destination.getStatements()
    }
    
    func passDataToStatements(source: LoginDataStore, destination: inout StatementsDataStore) {
        destination.user = source.user
    }
}
