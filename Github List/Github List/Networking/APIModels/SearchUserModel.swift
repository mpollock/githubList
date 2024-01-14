//
//  SearchUserModel.swift
//  Github List
//
//  Created by Michael on 1/13/24.
//

import Foundation

struct SearchUserModel: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Item]

    struct Item: Codable {
        let login: String
        let avatarUrl: URL?

        struct Mock {
            static var item = SearchUserModel.Item(
                login: "mpollock",
                avatarUrl: URL(string: "https://picsum.photos/100") // TODO: replace with static image?
            )
        }
    }

    struct Mock {
        static var result = SearchUserModel(
            totalCount: 1,
            incompleteResults: false,
            items: [Item.Mock.item]
        )
    }
}

