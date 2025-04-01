//
//  AccountSummaryViewControllerTests.swift
//  BankeyRedo
//
//  Created by Todd Smith on 4/1/25.
//

import Foundation
import XCTest

@testable import BankeyRedo

class AccountSummaryViewControllerTests: XCTestCase {
    
    var vc: AccountSummaryViewController!
    var mockManager: MockProfileManager!
    
    class MockProfileManager: ProfileManageable {
        
        var profile: Profile?
        var error: NetworkError?
        
        func fetchProfile(forUserID userID: String, completion: @escaping (Result<BankeyRedo.Profile, BankeyRedo.NetworkError>) -> Void) {
            
            if error != nil {
                completion(.failure(error!))
                return
            }
            
            profile = Profile(id: "1", firstName: "FirsName", lastName: "LastName")
            completion(.success(profile!))
        }
    }
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
        // vc.loadViewIfNeeded()
        mockManager = MockProfileManager()
        // mockProfileManager can be assigned to type ProfileManger because in viewController the profile manager is defined as var profileManager: ProfileManageable = ProfileManager()  by adding the protocol type, these are compatable.
        vc.profileManager = mockManager
    }
    
    func testTitleAndMessageForServerError() throws {
        
        let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("There was a Server Error.  Please try again later.", titleAndMessage.1)
    }
    
    func testTitleAndMessageForDecodingError() throws {
        
        let titleAndMessage = vc.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Decoding Error", titleAndMessage.0)
        XCTAssertEqual("There was an error decoding data received.  Please contact the helpdesk with error.", titleAndMessage.1)
    }
    
    func testAlertforServerError() throws {
        
        mockManager.error = .serverError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("There was a Server Error.  Please try again later.", vc.errorAlert.message)
    }
    
    func testAlertforDecodingError() throws {
        
        mockManager.error = .decodingError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Decoding Error", vc.errorAlert.title)
        XCTAssertEqual("There was an error decoding data received.  Please contact the helpdesk with error.", vc.errorAlert.message)
    }
}
