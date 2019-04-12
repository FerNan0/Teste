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
