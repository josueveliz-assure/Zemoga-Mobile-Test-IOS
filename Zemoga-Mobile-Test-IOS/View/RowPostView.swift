//
//  RowPostView.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 30/1/24.
//

import SwiftUI

struct RowPostView: View {
    var post: Post
    
    var body: some View {
        HStack {
            Text("\(post.body)")
                .font(.title3)
                .foregroundStyle(.primary)
            Spacer()
            Image(systemName: post.isFavorite ? "star.fill" : "star")
                .foregroundStyle(.yellow)
        }
    }
}

#Preview {
    RowPostView(post: Post(userID: 1, id: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "Body", isFavorite: true))
}
