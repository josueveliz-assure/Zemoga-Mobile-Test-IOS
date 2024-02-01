//
//  RowPostView.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 30/1/24.
//

import SwiftUI

struct RowPostView: View {
    var postContent: String
    var isFavorite: Bool
    
    var body: some View {
        HStack {
            Text("\(postContent)")
                .font(.title3)
                .foregroundStyle(.primary)
            Spacer()
            Image(systemName: isFavorite ? "star.fill" : "star")
                .foregroundStyle(.yellow)
        }
    }
}

#Preview {
    RowPostView(postContent: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", isFavorite: true)
}
