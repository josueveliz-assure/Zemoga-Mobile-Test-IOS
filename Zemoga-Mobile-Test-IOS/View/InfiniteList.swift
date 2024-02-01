//
//  InfiniteScrolling4.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 1/2/24.
//

import SwiftUI

struct InfiniteList: View {
    var postDetail: Post = Post(userID: 1, id: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit sunt aut facere repellat provident occaecati excepturi optio reprehenderit sunt aut facere repellat provident occaecati excepturi optio reprehenderit", isFavorite: true)
    var userDetail: User = User(id: 1, name: "Josue", username: "josueveliz", email: "josue@gmail.com", address: Address(street: "street", suite: "suite", city: "city", zipcode: "zipcode", geo: Geo(lat: "lat", lng: "lng")), phone: "+592 69482428", website: "josueeliz.69.com", company: Company(name: "name", catchPhrase: "catchPhrase", bs: "bs"))
    var commentsDetail: [Comment] = [
        Comment(postID: 1, id: 1, name: "Josue", email: "jso@gmail.com", body: "Body sfsdf sdfqwsdf asdasd asq lorem asdad dfasd sdfsdf se q"),
        Comment(postID: 1, id: 2, name: "Josue", email: "asdf@gmail.com", body: "lorem asdad dfasd sdfsdf se q lorem asdad dfasd sdfsdf se q lorem a")
    ]
    
    private var postListViewModel = PostListViewModel()
    @State private var currentPage: Int = 1
    
    var body: some View {
        CustomNavView {
            List {
                ForEach(postListViewModel.posts, id: \.id) { post in
                    CustomNavLinkView(
                        destination:
                            DetailPostView(post: postDetail, user: userDetail, comments: commentsDetail)
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
            .customNavigationTitle("Posts")
            .customNavigationBackButtonHidden(true)
            .customNavigationBackgroundColor("#27AE60")
            .customNavigationForegroundColor("#FBFCFC")
            .customNavigationButtonProperties(ButtonProperties(systemImage: "arrow.triangle.2.circlepath.circle", action: {
                print("Action")
            }))
            .listStyle(.plain)
            
        }
        .task {
            await postListViewModel.getPosts(page: currentPage)
        }
    }
}


#Preview {
    InfiniteList()
}
