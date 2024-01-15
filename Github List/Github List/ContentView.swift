//
//  ContentView.swift
//  Github List
//
//  Created by Michael on 1/13/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .loading:
                HStack {
                    Text("Loading")
                    ProgressView()
                }
            case .loaded(let users):
                List {
                    ForEach(users) { user in
                        UserCellView(viewModel: UserCellViewModel(user: user))
                            .onAppear {
                                if users.count > 11 {
                                    if user == users[users.count - 11] {
                                        Task {
                                            await viewModel.getNextUserPage(username: searchText)
                                        }
                                    }
                                }
                            }
                    }
                }
            case .error(let error):
                Text("Error \(error.localizedDescription)")
            }
        }
        // searchCompletion of previous searches could be nice
        .searchable(text: $searchText)
        .onSubmit(of: .search, runSearch)
    }

    private func runSearch() {
        Task {
            await viewModel.userSearch(username: searchText)
        }
    }
}

#Preview {
    ContentView()
}
