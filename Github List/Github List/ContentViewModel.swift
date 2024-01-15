//
//  ContentViewModel.swift
//  Github List
//
//  Created by Michael on 1/13/24.
//

import Foundation

@MainActor final class ContentViewModel: ObservableObject {
    @Published var state: LoadingState<[UserModel]> = .loaded([])
    var page: Int = 1

    func userSearch(username: String) async {
        page = 1
        state = .loading
        do {
            let searchResults = try await GithubEndpoints.shared.searchUsers(query: username, page: page)
            let users = try await searchResults.items.concurrentMap { item in
                try await GithubEndpoints.shared.getUser(username: item.login)
            }
            state = .loaded(users)
        } catch {
            state = .error(error)
        }
    }

    func getNextUserPage(username: String) async {
        page += 1
        do {
            let searchResults = try await GithubEndpoints.shared.searchUsers(query: username, page: page)
            let newUsers = try await searchResults.items.concurrentMap { item in
                try await GithubEndpoints.shared.getUser(username: item.login)
            }
            switch state {
            case .loaded(let users):
                let totalUsers = users + newUsers
                state = .loaded(totalUsers)
            default:
                return
            }
        } catch {
            state = .error(error)
        }
    }
}

// This is taken from swiftbysundell in order to load our user data concurrently
// https://www.swiftbysundell.com/articles/async-and-concurrent-forEach-and-map/
extension Sequence {
    func asyncMap<T>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }

    func concurrentMap<T>(_ transform: @escaping (Element) async throws -> T) async throws -> [T] {
        let tasks = map { element in
            Task {
                try await transform(element)
            }
        }

        return try await tasks.asyncMap { task in
            try await task.value
        }
    }
}
