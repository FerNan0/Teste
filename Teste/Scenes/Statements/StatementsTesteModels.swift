//
//  StatementsTesteModels.swift
//  Teste
//
//  Created by Fernando Duarte on 12/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import Foundation

struct Statement {
    var title: String = ""
    var desc: String = ""
    var date: String = ""
    var value: Double = 0.0
    public init(dictionary: NSDictionary) {
        self.title = dictionary["title"] as! String
        self.desc = dictionary["desc"] as! String
        self.date = dictionary["date"] as! String
        self.value = dictionary["value"] as! Double
    }
}

class ResponseStatements {
    var statements: [Statement] = [Statement]()
    var balance: Double = 0.0
    var error: Error?
    
    public init(dictionary: NSDictionary) {
        if let error = dictionary["error"] as? NSDictionary {
            let errorObj = Error(dictionary: error)
            if errorObj.code != nil {
                self.error = Error(dictionary: error)
            } else {
                if let statementList = dictionary["statementList"] as? [NSDictionary] {
                    
                    for statement in statementList {
                        let statementAux = Statement(dictionary: statement)
                        statements.append(statementAux)
                        balance += statementAux.value
                    }
                }
            }
        }
    }
}
