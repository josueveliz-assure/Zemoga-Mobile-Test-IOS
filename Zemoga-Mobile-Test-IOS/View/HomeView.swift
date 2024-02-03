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
    
    @State private var isDeleted = false
    @State private var isReload = false
    @State private var isCharge = false
    
    @State private var showingAlert = false
    @State private var showingLateralAlert = false
    @State private var showingSqueleton = true
    @State private var showingCreatePost = false
    
    @State private var postIdToDelete: Int = 0
    
    var body: some View {
        ZStack {
            CustomNavView {
                VStack {
                    Picker("Tabs", selection: $selectedTab) {
                        Text("tab-option-all").tag(0)
                        Text("tab-option-favorites").tag(1)
                    }
                    .padding(.top, 8)
                    .padding([.leading, .trailing])
                    .pickerStyle(.segmented)
                    .background(.gray.opacity(0.01))
                    .clipShape(RoundedRectangle(cornerRadius: 0))
                    .onChange(of: selectedTab) {
                        postListViewModel.isFavoriteFilterActive = selectedTab == 1
                        postListViewModel.filterPost()
                        showingSqueleton = selectedTab == 0
                    }
                    
                    ZStack {
                        List {
                            ForEach($postListViewModel.posts, id: \.id) { $post in
                                CustomNavLinkView(
                                    destination:
                                        DetailPostView(
                                            postContent: post.body,
                                            isFavorite: post.isFavorite,
                                            user: detailPostViewModel.user ?? User.sample[0],
                                            comments: detailPostViewModel.comments
                                        )
                                        .redactShimmer(condition: detailPostViewModel.isLoading)
                                        .task {
                                            await detailPostViewModel.getDetailData(userId: post.userID, postId: post.id)
                                        }
                                        .customNavigationTitle("home-individual-title")
                                        .customNavigationBackgroundColor("#27AE60")
                                        .customNavigationForegroundColor("#FBFCFC")
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
                                            Label("delete-text", systemImage: "trash")
                                        }
                                        .tint(.red)
                                    }.alert(isPresented: $showingLateralAlert) {
                                        Alert(
                                            title: Text("delete-post"),
                                            message: Text("question-delete-post \(String(postIdToDelete))"),
                                            primaryButton: .destructive(Text("delete-text")) {
                                                postListViewModel.removePost(postId: postIdToDelete)
                                            },
                                            secondaryButton: .cancel()
                                        )
                                    }
                                }
                                .padding(.vertical, 7)
                                
                            }
                            
                            if showingSqueleton && !isDeleted {
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
                            } else {
                                if postListViewModel.posts.isEmpty {
                                    Text("no-data")
                                        .font(.title2)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .padding()
                                }
                            }
                            
                        }
                        .listStyle(.plain)
                        
                        FloatingActionButtomView(toogle: $showingCreatePost)
                    }
                    
                    
                    Button(
                        action: {
                            showingAlert = true
                        }
                    ) {
                        Text("delete-all")
                            .font(.title2)
                    }
                    .padding(.top)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("delete-all"),
                            message: Text("question-delete-all"),
                            primaryButton: .destructive(Text("delete-text")) {
                                postListViewModel.deleteData()
                                showingSqueleton = false
                                isDeleted = true
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                .customNavigationTitle("home-title")
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
                                    showingSqueleton = true
                                    isCharge = false
                                    isDeleted = false
                                    await postListViewModel.reload()
                                    isReload = false
                                }
                            }
                        }
                    )
                )
            }
            
            ModalView(
                isShowing: $showingCreatePost,
                marginColor: CustomColor(hex: "#f2f2f7").color) {
                    CreatePostFormView()
            }
        }
    }
}

#Preview {
    HomeView()
}
