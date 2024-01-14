//
//  ContentViewModel.swift
//  Github List
//
//  Created by Michael on 1/13/24.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var data: SearchUserModel?

    func fetchData() async {
        do {
            data = try await GithubEndpoints().searchUsers(query: "mpollock")
        } catch {
            data = nil
        }
    }
}
