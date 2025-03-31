//
//  AccountSummaryCellsTests.swift
//  BankeyRedo
//
//  Created by Todd Smith on 3/27/25.
//

import Foundation
import XCTest

@testable import BankeyRedo

class AccountSummaryCellsTests: XCTestCase {
    
    let accountsJSON = """
        [
          {
            "id": "1",
            "type": "Banking",
            "name": "Basic Savings",
            "amount": 929466.23,
            "createdDateTime" : "2010-06-21T15:29:32Z"
          },
          {
            "id": "2",
            "type": "Banking",
            "name": "No-Fee All-In Chequing",
            "amount": 17562.44,
            "createdDateTime" : "2011-06-21T15:29:32Z"
          },
          {
            "id": "3",
            "type": "CreditCard",
            "name": "Visa Avion Card",
            "amount": 412.83,
            "createdDateTime" : "2012-06-21T15:29:32Z"
          },
          {
            "id": "4",
            "type": "CreditCard",
            "name": "Student Mastercard",
            "amount": 50.83,
            "createdDateTime" : "2013-06-21T15:29:32Z"
          },
          {
            "id": "5",
            "type": "Investment",
            "name": "Tax-Free Saver",
            "amount": 2000.00,
            "createdDateTime" : "2014-06-21T15:29:32Z"
          },
          {
            "id": "6",
            "type": "Investment",
            "name": "Growth Fund",
            "amount": 15000.00,
            "createdDateTime" : "2015-06-21T15:29:32Z"
          },
         ]
    """
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testCanParseAccounts() {
        
        let data = accountsJSON.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let result = try! decoder.decode([Account].self, from: data)
        
        XCTAssertEqual(result.count, 6)
        
        XCTAssertEqual(result[0].type, .Banking)
        XCTAssertEqual(result[3].type, .CreditCard)
        XCTAssertEqual(result[5].createdDateTime.monthDayYearString, "Jun 21, 2015")
    }
    
}


