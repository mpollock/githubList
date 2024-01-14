//
//  GithubEndpoints.swift
//  Github List
//
//  Created by Michael on 1/13/24.
//

import Foundation

class GithubEndpoints {
    static var shared = GithubEndpoints()

    var shouldUseMockData = false

    /// Retrieves the video livestream details for a given device.
    ///
    /// - Parameter query: The specific query to search for
    /// - Returns: SearchUserModel, a list of resulting users from the search
    /// - Throws: Error for request or decoding failure of primary response object
    public func searchUsers(query: String) async throws -> SearchUserModel {
        let endpoint = Endpoint.searchUsers(query: query)

        guard let request = URLRequest(endpoint: endpoint) else {
            throw NetworkError.invalidRequest
        }

        if shouldUseMockData {
            return SearchUserModel.Mock.result
        } else {
            return try await APIClient.shared.requestData(for: request)
        }
    }

    /// Retrieves the video livestream details for a given device.
    ///
    /// - Parameter username: The specific user to get info for
    /// - Returns: SearchUserModel, a list of resulting users from the search
    /// - Throws: Error for request or decoding failure of primary response object
    public func getUser(username: String) async throws -> UserModel {
        let endpoint = Endpoint.getUser(username: username)

        guard let request = URLRequest(endpoint: endpoint) else {
            throw NetworkError.invalidRequest
        }

        if shouldUseMockData {
            return UserModel.Mock.user
        } else {
            return try await APIClient.shared.requestData(for: request)
        }
    }
}

extension Endpoint {
    static func searchUsers(query: String) -> Endpoint {
        return Endpoint(
            path: "/search/users",
            method: .GET,
            queryParameters: ["q": query]
                .compactMapValues({$0}),
            useMock: false
        )
    }

    static func getUser(username: String) -> Endpoint {
        return Endpoint(
            path: "/users/\(username)",
            method: .GET,
            useMock: false
        )
    }
}
