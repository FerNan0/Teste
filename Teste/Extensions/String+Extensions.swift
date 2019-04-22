//
//  String+Extensions.swift
//  Teste
//
//  Created by Fernando Duarte on 16/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

extension  String {
    func convertDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = inputFormatter.date(from: self)
        inputFormatter.dateFormat = "dd/MM/yyyy"
        if let date = showDate {
            return inputFormatter.string(from: date)
        }
        return ""
    }
    
    func isCPFValid() -> Bool {        
        let numbers = compactMap({ Int(String($0)) })
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        func digitCalculator(_ slice: ArraySlice<Int>) -> Int {
            var number = slice.count + 2
            let digit = 11 - slice.reduce(into: 0) {
                number -= 1
                $0 += $1 * number
                } % 11
            return digit > 9 ? 0 : digit
        }
        let dv1 = digitCalculator(numbers.prefix(9))
        let dv2 = digitCalculator(numbers.prefix(10))
        return dv1 == numbers[9] && dv2 == numbers[10]
    }

}
