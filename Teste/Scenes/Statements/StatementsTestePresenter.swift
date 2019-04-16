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
}
