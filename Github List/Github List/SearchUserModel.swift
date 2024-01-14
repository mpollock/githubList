//
//  SearchUserModel.swift
//  Github List
//
//  Created by Michael on 1/13/24.
//

import Foundation

struct SearchUserModel: Codable {
    var totalCount: Int
    var incompleteResults: Bool
    var items: [Item]

    struct Item: Codable {
        var login: String
        var id: Int
        var avatarUrl: String
        var url: String
        var htmlUrl: String
    }

    struct Mock {
        static var result = SearchUserModel(
            totalCount: 1,
            incompleteResults: false,
            items: [
                SearchUserModel.Item(
                    login: "test",
                    id: 1,
                    avatarUrl: "",
                    url: "",
                    htmlUrl: "")
            ]
        )
    }
}

