//
//  HomeView.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 1/2/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0
    
    @Bindable private var postListViewModel = PostListViewModel()
    private var detailPostViewModel = DetailPostViewModel()
    @State private var isFavorite = false
    @State private var isDeleted = false
    @State private var isReload = false
    @State private var isCharge = false
    @State private var showingAlert = false
    @State private var showingLateralAlert = false
    @State private var postIdToDelete: Int = 0
    
    var body: some View {
        CustomNavView {
            VStack {
                Picker("Tabs", selection: $selectedTab) {
                    Text("All").tag(0)
                    Text("Favorites").tag(1)
                }
                .padding(.top, 8)
                .padding([.leading, .trailing])
                .pickerStyle(.segmented)
                .background(.gray.opacity(0.01))
                .clipShape(RoundedRectangle(cornerRadius: 0))
                .onChange(of: selectedTab) {
                    print("Selected tab: \(selectedTab)")
                }
                
                List {
                    ForEach($postListViewModel.posts, id: \.id) { $post in
                        CustomNavLinkView(
                            destination:
                                DetailPostView(
                                    postContent: post.body,
                                    isFavorite: isFavorite,
                                    user: detailPostViewModel.user ?? User.sample[0],
                                    comments: detailPostViewModel.comments
                                )
                                .redactShimmer(condition: detailPostViewModel.isLoading)
                                .task {
                                    await detailPostViewModel.getDetailData(userId: post.userID, postId: post.id)
                                }
                                .customNavigationBackgroundColor("#27AE60")
                                .customNavigationForegroundColor("#FBFCFC")
                                .customNavigationTitle("Posts")
                                .customNavigationButtonProperties(
                                    ButtonProperties(
                                        systemImage: post.isFavorite ? "star.fill" : "star",
                                        action: {
                                            postListViewModel.updateFavoritePost(post: $post)
                                        }
                                    ))
                        ) {
                            RowPostView(
                                postContent: post.title,
                                isFavorite: post.isFavorite
                            )
                            .redactShimmer(condition: postListViewModel.isLoading)
                            .swipeActions(edge: .trailing) {
                                Button {
                                    postListViewModel.updateFavoritePost(post: $post)
                                } label: {
                                    Label("Favorite", systemImage: "star")
                                }
                                .tint(.yellow)
                            }
                            .swipeActions(edge: .leading) {
                                Button() {
                                    showingLateralAlert = true
                                    postIdToDelete = post.id
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.red)
                            }.alert(isPresented: $showingLateralAlert) {
                                Alert(
                                    title: Text("Delete Post"),
                                    message: Text("Are you sure you want to delete this post?"),
                                    primaryButton: .destructive(Text("Delete")) {
                                        postListViewModel.removePost(postId: postIdToDelete)
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                        }
                        .padding(.vertical, 7)
                        
                    }
                    
                    if !isDeleted {
                        RowPostView(postContent: Post.sample[0].body, isFavorite: false)
                            .redactShimmer(condition: true)
                            .onAppear {
                                if !isReload || isCharge {
                                    Task {
                                        await postListViewModel.populateData()
                                        isReload = false
                                        isCharge = true
                                    }
                                }
                            }
                        ForEach(0..<2, id: \.self) { _ in
                            RowPostView(postContent: Post.sample[1].body, isFavorite: false)
                                .redactShimmer(condition: true)
                        }
                    }
                    
                }
                .listStyle(.plain)
                .onAppear(){
                    
                }
                
                Button(
                    action: {
                        showingAlert = true
                    }
                ) {
                    Text("Delete All")
                        .font(.title2)
                }
                .padding(.top)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.red)
                .foregroundColor(.white)
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Delete All"),
                        message: Text("Are you sure you want to delete all posts?"),
                        primaryButton: .destructive(Text("Delete")) {
                            postListViewModel.deleteData()
                            isDeleted = true
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .customNavigationTitle("Posts")
            .customNavigationBackButtonHidden(true)
            .customNavigationBackgroundColor("#27AE60")
            .customNavigationForegroundColor("#FBFCFC")
            .customNavigationButtonProperties(
                ButtonProperties(
                    systemImage: "arrow.triangle.2.circlepath.circle",
                    action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            Task {
                                isReload = true
                                isDeleted = false
                                isCharge = false
                                await postListViewModel.reload()
                                isReload = false
                            }
                        }
                    }
                )
            )
        }
    }
}

#Preview {
    HomeView()
}
