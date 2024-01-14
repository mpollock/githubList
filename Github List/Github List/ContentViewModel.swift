//
//  ContentViewModel.swift
//  Github List
//
//  Created by Michael on 1/13/24.
//

import Foundation

@MainActor final class ContentViewModel: ObservableObject {
    @Published var state: LoadingState<[UserModel]> = .loading

    func fetchData() async {
        state = .loading
        do {
            let searchResults = try await GithubEndpoints.shared.searchUsers(query: "mpollock")
            let users = try await searchResults.items.concurrentMap { item in
                try await GithubEndpoints.shared.getUser(username: item.login)
            }
            state = .loaded(users)
        } catch {
            state = .error(error)
        }
    }
}

// This is taken from swiftbysundell
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
