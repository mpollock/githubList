//
//  UserCellView.swift
//  Github List
//
//  Created by Michael on 1/14/24.
//

import SwiftUI

struct UserCellView: View {
    @StateObject var viewModel: UserCellViewModel

    var body: some View {
        HStack {
            AsyncImage(url: viewModel.user.avatarUrl) { image in
                image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
                    .frame(width: 50, height: 50)
            }
            VStack(alignment: .leading) {
                Text(viewModel.user.name ?? viewModel.user.login)
                Label(viewModel.user.publicRepos.description, systemImage: "book.closed.fill")
            }
        }
    }
}

#Preview {
    UserCellView(viewModel: UserCellViewModel(user: UserModel.Mock.user))
}
