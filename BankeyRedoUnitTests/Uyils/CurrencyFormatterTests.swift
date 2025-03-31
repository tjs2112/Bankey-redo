//
//  CurrencyFormatterTests.swift
//  BankeyRedo
//
//  Created by Todd Smith on 3/17/25.
//

import Foundation
import XCTest

@testable import BankeyRedo

class Test: XCTestCase {
    
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
        
    }
    
    func testBreakIntoDollarsAndCents() throws {
        
        let result = formatter.breakIntoDollarsAndCents(929466.34567)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "35")
        
    }
    
    func testDollarsFormatted() throws {
        
        let result = formatter.dollarsFormatted(929466.34567)
        XCTAssertEqual(result, "$929,466.35")
    }
    
    func testZeroDollarsFormatted() throws {
        
        let result = formatter.dollarsFormatted(0)
        XCTAssertEqual(result, "$0.00")
        
    }
    
    func testSingleDigitDecimalDollarsFormatted() throws {
        
        let result = formatter.dollarsFormatted(4.1)
        XCTAssertEqual(result, "$4.10")
    }
}

