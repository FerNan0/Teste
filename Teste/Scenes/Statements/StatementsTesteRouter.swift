//
//  StatementsTesteRouter.swift
//  Teste
//
//  Created by Fernando Duarte on 12/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

protocol StatementsDataPassing
{
    var dataStore: StatementsDataStore? { get }
}

class StatementsTesteRouter: NSObject, StatementsDataPassing {
    var dataStore: StatementsDataStore?
    var viewController: StatementsTesteViewController?
}
