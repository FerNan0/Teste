//
//  StatementsTesteInteractor.swift
//  Teste
//
//  Created by Fernando Duarte on 12/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

protocol StatementsDataStore {
    var user: UserAccount! { get set }
}

class StatementsTesteInteractor: StatementsDataStore {
    var user: UserAccount!
    

}
