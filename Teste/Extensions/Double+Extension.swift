//
//  String+Extension.swift
//  Teste
//
//  Created by Fernando Duarte on 16/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

extension Double {
    func currency() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "pt_BR")
        return currencyFormatter.string(from: NSNumber(value: self))!        
    }
}
