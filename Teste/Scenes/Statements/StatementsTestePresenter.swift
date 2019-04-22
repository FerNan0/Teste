//
//  StatementsTestePresenter.swift
//  Teste
//
//  Created by Fernando Duarte on 12/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

protocol ResponseStatementsProtocol {
    func responseStatements(response: ResponseStatements)
    func setHeader(user: UserAccount, statements: ResponseStatements)
}

class StatementsTestePresenter: ResponseStatementsProtocol {
    var viewController: ResponseStatementsFromURLProtocol?
    
    func responseStatements(response: ResponseStatements) {
        if response.error?.code != nil {
            if let error = response.error {
                viewController?.responseStatementsError(response: error)
            }
        } else {
            viewController?.responseStatementsValid()            
        }
    }
    
    func setHeader(user: UserAccount, statements: ResponseStatements) {
        let name = user.name
        let bankAcc = formatAccount(agency: user.bankAccount, acc: user.agency)
        let balance = statements.balance.currency()
        viewController?.setHeader(name: name, bank: bankAcc, balance: balance)
    }
    
    func formatAccount(agency: String, acc: String) -> String {
        var accFormated = acc
        accFormated.insert(".", at: accFormated.index(accFormated.startIndex, offsetBy: 2))
        accFormated.insert("-", at: accFormated.index(accFormated.endIndex, offsetBy: -1))
        let account = agency + " / " + accFormated
        return account
    }

}
