//
//  StatementsTesteWorker.swift
//  Teste
//
//  Created by Fernando Duarte on 12/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import Foundation
import Alamofire

enum urlStatements: String {
    case statements = "https://bank-app-test.herokuapp.com/api/statements/{idUser}"
}

protocol CallsStatements {
    func callStatements(id: Int, completion: @escaping (ResponseStatements) -> Void)
}

class StatementsTesteWorker: CallsStatements
{
    func callStatements(id: Int, completion: @escaping (ResponseStatements) -> Void)
    {
        let aux = urlStatements.statements.rawValue.replacingOccurrences(of: "{idUser}", with: String(format: "%d", id))
        Alamofire.request(aux, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: { response in
            let jsonResponse = ResponseStatements(dictionary: response.result.value as! NSDictionary)
            print(jsonResponse)
            completion(jsonResponse)
        })
    }
}

