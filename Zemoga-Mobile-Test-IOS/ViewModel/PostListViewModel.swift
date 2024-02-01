//
//  PostListViewModel.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 1/2/24.
//

import Foundation

@Observable final class PostListViewModel {
    var isLoading: Bool = false
    var posts: [Post] = Post.sample
    
    func getPosts(page: Int) async {
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
    
    func populateData(page: Int) async {
        do {
            let duration = Duration(secondsComponent: 2, attosecondsComponent: 0)
            try await Task.sleep(for: duration)
            
            ApiManager.shared.getPosts(page: page, limit: 10) { result in
                switch result {
                case .success(let posts):
                    print("Fetched \(posts.count) posts.")
                    self.posts.append(contentsOf: posts)
                case .failure(let error):
                    print("Error fetching posts: \(error)")
                }
            }
        } catch {
            posts = []
            print(error.localizedDescription)
        }
    }
}
