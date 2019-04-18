//
//  StatementsTesteTests.swift
//  TesteTests
//
//  Created by Fernando Duarte on 10/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import XCTest
@testable import Teste

class StatementsTesteTests: XCTestCase {
    var dateFromServer: String?
    var dateCorrectly: String?
    var dateIncorrectly: String?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dateFromServer = "2001-09-11"
        dateCorrectly = "11/09/2001"
        dateIncorrectly = "11/10/2011"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testConvertDateStringTest() {
        //dado que a data é retornada pelo servidor no formato yyyy-mm-dd
        //quando quero exibir no padrão Brasileiro dd/mm/yyy
        //então é chamado a função .convertDate() e é formatado
        XCTAssertNotEqual(dateFromServer?.convertDate(), dateIncorrectly)
        XCTAssertEqual(dateFromServer?.convertDate(), dateCorrectly)
    }
    
    func testConvertDoubleStringTest() {
        //dado que tenho um saldo do tipo double
        //quando quero exibir esse saldo
        //então é chamado a função .currency() e é formatado no padrão monetário local
        XCTAssertNotEqual(1900.0.currency(), "$ 1,900.00")
        XCTAssertEqual(1900.0.currency(), "R$ 1.900,00")
    }
    
}
