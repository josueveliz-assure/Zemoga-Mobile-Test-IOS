//
//  PostListViewModel.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 1/2/24.
//

import Foundation
import SwiftUI

@Observable final class PostListViewModel {
    var isLoading: Bool = false
    var page: Int = 1
    var posts: [Post] = []
    var isFavoriteFilterActive: Bool = false
    
    func getPosts() async {
        defer { isLoading = false }
        do {
            isLoading = true
            
            let duration = Duration(secondsComponent: 2, attosecondsComponent: 0)
            try await Task.sleep(for: duration)
            
            
            ApiManager.shared.getPosts(page: page, limit: 10) { result in
                switch result {
                case .success(let posts):
                    print("Fetched \(posts.count) posts.")
                    self.posts = posts
                case .failure(let error):
                    print("Error fetching posts: \(error)")
                }
            }
        } catch {
            posts = []
            print(error.localizedDescription)
        }
    }
    
    func populateData() async {
        do {
            
            let duration = Duration(secondsComponent: 2, attosecondsComponent: 0)
            try await Task.sleep(for: duration)
            
            ApiManager.shared.getPosts(page: page, limit: 10) { result in
                switch result {
                case .success(let posts):
                    print("Fetched \(posts.count) posts.")
                    self.posts.append(contentsOf: posts)
                    self.page += 1
                case .failure(let error):
                    print("Error fetching posts: \(error)")
                }
            }
        } catch {
            posts = []
            print(error.localizedDescription)
        }
    }
    
    func filterPosts() -> [Post] {
        return isFavoriteFilterActive ? posts.filter { $0.isFavorite } : posts
    }
    
    func reload() async {
        page = 1
        posts.removeAll()
        await getPosts()
        page += 1
    }
    
    func deleteData() {
        posts.removeAll()
        page = 1
    }
    
    func removePost(postId: Int) {
        posts.removeAll { $0.id == postId }
    }
    
    func favoritePost(postId: Int) {
        if let index = posts.firstIndex(where: { $0.id == postId }) {
            posts[index].isFavorite.toggle()
        }
    }
    
    func updateFavoritePost(post: Binding<Post>) {
        post.wrappedValue.isFavorite.toggle()
    }
}
