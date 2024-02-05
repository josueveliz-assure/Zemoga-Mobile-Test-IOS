//
//  CreatePostFormView.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 3/2/24.
//

import SwiftUI

struct CreatePostFormView: View {
    @State private var postTitle: String = ""
    @State private var postContent: String = ""
    var postListViewModel: PostListViewModel
    var action: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("post-content")) {
                    TextField("title", text: $postTitle)
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $postContent)
                            .frame(height: 150)
                        if postContent.isEmpty {
                            Text("content")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                .padding(.leading, 4)
                        }
                    }
                }
            }
            .tint(CustomColor(hex: "#27AE60").color)
            .navigationTitle("home-individual-title")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        postListViewModel.addPost(post: NewPost(userID: 777, title: postTitle, body: postContent))
                        action()
                    }) {
                        Text("save")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing, 10)
                    .padding(.leading, 6)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .padding(.top)
    }
}

#Preview {
    CreatePostFormView(postListViewModel: PostListViewModel(),action: {})
}
