//
//  UserModel.swift
//  Github List
//
//  Created by Michael on 1/14/24.
//

import Foundation

struct UserModel: Codable, Identifiable {
    var id: String {
        login
    }
    let login: String
    let avatarUrl: URL?
    let name: String?
    let publicRepos: Int

    struct Mock {
        static let user = UserModel(login: "mpollock", 
                                    avatarUrl: URL(string: "https://picsum.photos/100"),
                                    name: "Michael Pollock", 
                                    publicRepos: 6)
    }
}
