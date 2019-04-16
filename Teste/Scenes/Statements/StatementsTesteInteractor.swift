//
//  StatementsTesteInteractor.swift
//  Teste
//
//  Created by Fernando Duarte on 12/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

protocol StatementsProtocol {
    func getStatements(id: Int)
}

protocol StatementsDataStore {
    var user: UserAccount! { get set }
    var responseStatements: ResponseStatements? { get set }
}

class StatementsTesteInteractor: StatementsDataStore, StatementsProtocol {
    var user: UserAccount!
    var worker: CallsStatements?
    var presenter: ResponseStatementsProtocol?
    var responseStatements: ResponseStatements?
    
    func getStatements(id: Int) {
        worker?.callStatements(id: id, completion: { response in
            self.fetchStatements(response: response)
            self.presenter?.responseStatements(response: response)
        })
    }
    
    func fetchStatements(response: ResponseStatements) {
        self.responseStatements = response
    }
    
}
