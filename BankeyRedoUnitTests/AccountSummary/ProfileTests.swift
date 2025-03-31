//
//  ProfilwTests.swift
//  BankeyRedo
//
//  Created by Todd Smith on 3/27/25.
//

import Foundation
import XCTest

@testable import BankeyRedo

class ProfileTests: XCTestCase {
    
    let testJSON = """
        {
        "id": "1",
        "first_name": "Kevin",
        "last_name": "Flynn",
        }
    """
    
    override func setUp() {
        
        super.setUp()
    }
    
    func testCanParseProfile() {
        
        let data = testJSON.data(using: .utf8)!
        
        let result = try! JSONDecoder().decode(Profile.self, from: data)
        
        XCTAssertEqual(result.id, "1")
        XCTAssertEqual(result.firstName, "Kevin")
        XCTAssertEqual(result.lastName, "Flynn")
    }
}
