//
//  InfiniteScrolling4.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 1/2/24.
//

import SwiftUI

struct InfiniteList: View {
    private var postListViewModel = PostListViewModel()
    @State private var currentPage: Int = 1
    
    var body: some View {
        List {
            ForEach(postListViewModel.posts, id: \.id) { post in
                CustomNavLinkView(
                    destination:
                        DetailPostView(postContent: post.body, isFavorite: post.isFavorite, userId: post.userID, postId: post.id)
                        .customNavigationBackgroundColor("#27AE60")
                        .customNavigationForegroundColor("#FBFCFC")
                        .customNavigationTitle("Posts")
                        .customNavigationButtonProperties(ButtonProperties(systemImage: "star", action: {
                            print("Action")
                        }))
                ) {
                    RowPostView(postContent: post.body, isFavorite: post.isFavorite)
                        .redactShimmer(condition: postListViewModel.isLoading)
                        .swipeActions(edge: .trailing) {
                            Button {
                                print("Favorite")
                            } label: {
                                Label("Favorite", systemImage: "star")
                            }
                            .tint(.yellow)
                        }
                        .swipeActions(edge: .leading) {
                            Button() {
                                print("Delete")
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                        }
                    
                }
                .padding(.vertical, 7)
                
            }
            
            RowPostView(postContent: Post.sample[0].body, isFavorite: false)
                .redactShimmer(condition: true)
                .onAppear {
                    currentPage += 1
                    Task {
                        await postListViewModel.populateData(page: currentPage)
                    }
                }
            
        }
        .listStyle(.plain)
        .task {
            await postListViewModel.getPosts(page: currentPage)
        }
    }
}


#Preview {
    CustomNavView {
        InfiniteList()
            .customNavigationTitle("Posts")
            .customNavigationBackButtonHidden(true)
            .customNavigationBackgroundColor("#27AE60")
            .customNavigationForegroundColor("#FBFCFC")
            .customNavigationButtonProperties(ButtonProperties(systemImage: "arrow.triangle.2.circlepath.circle", action: {
                print("Action")
            }))
    }
}
