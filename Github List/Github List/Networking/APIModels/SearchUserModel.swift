//
//  SearchUserModel.swift
//  Github List
//
//  Created by Michael on 1/13/24.
//

import Foundation

struct SearchUserModel: Codable {
    let items: [Item]

    struct Item: Codable {
        let login: String

        struct Mock {
            static var item = SearchUserModel.Item(
                login: "mpollock"
            )
        }
    }

    struct Mock {
        static var result = SearchUserModel(
            items: [Item.Mock.item]
        )
    }
}

