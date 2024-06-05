//
//  APIManagerTests.swift
//  iosAssigmentTests
//
//  Created by Macbook on 04/06/2024.
//


import XCTest

@testable import iosAssigment
 
class APIManagerTests: XCTestCase {

    var apiManager: APIManager!

    override func setUp() {

        super.setUp()

        apiManager = APIManager.shared

    }

    override func tearDown() {

        apiManager = nil

        super.tearDown()

    }

    func testFetchUsers() {

        let expectation = XCTestExpectation(description: "Fetch users from API")

        apiManager.fetchUsers { users in

            if let users = users {

                XCTAssertGreaterThan(users.count, 0, "Users array should not be empty")

                for user in users {

                    XCTAssertNotNil(user.login, "User login should not be nil")

                    XCTAssertNotNil(user.avatarUrl, "User avatar URL should not be nil")

                    XCTAssertNotNil(user.htmlUrl, "User HTML URL should not be nil")
                    print(users.count)

                }

            } else {

                XCTFail("Failed to fetch users from API")

                print("Failed to fetch users from API")
            }

            expectation.fulfill()

        }

        wait(for: [expectation], timeout: 10.0)

    }

}
