//
//  UserCellViewModel.swift
//  Github List
//
//  Created by Michael on 1/14/24.
//

import Foundation

final class UserCellViewModel: ObservableObject {
    @Published var user: UserModel

    init(user: UserModel) {
        self.user = user
    }
}
