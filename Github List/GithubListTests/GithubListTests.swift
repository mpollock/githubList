//
//  GithubListTests.swift
//  GithubListTests
//
//  Created by Michael on 1/15/24.
//

import XCTest
@testable import Github_List

final class GithubListTests: XCTestCase {
    let endpoints = GithubEndpoints()

    override func setUpWithError() throws {
        endpoints.shouldUseMockData = true
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // This test doesn't actually test anything helpful, but I wanted to show that I know how to write a simple unit
    // test.
    func testSearch() throws {
        Task {
            let users = try await endpoints.searchUsers(query: "mpollock", page: 1)
            XCTAssertEqual(users.items.count, 1)
        }

    }

}
