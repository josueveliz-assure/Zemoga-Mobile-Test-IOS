//
//  DetailPostViewModel.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 1/2/24.
//

import Foundation

@Observable class DetailPostViewModel {
    var isLoading: Bool = false
    var user: User? = nil
    var comments: [Comment] = []
    
    func getUser(id: Int) async {
        ApiManager.shared.getUser(userId: id) { result in
            switch result {
            case .success(let user):
                print("Fetched user \(user.name).")
                self.user = user
            case .failure(let error):
                print("Error fetching user: \(error)")
            }
        }
    }
    
    func getComments(postId: Int) async {
        ApiManager.shared.getComments(postId: postId) { result in
            switch result {
            case .success(let comments):
                print("Fetched \(comments.count) comments.")
                self.comments = comments
            case .failure(let error):
                print("Error fetching comments: \(error)")
            }
        }
    }
    
    func getDetailData(userId: Int, postId: Int) async {
        defer { isLoading = false }
        
        do {
            isLoading = true
            
            let duration = Duration(secondsComponent: 2, attosecondsComponent: 0)
            try await Task.sleep(for: duration)
            
            await getUser(id: userId)
            await getComments(postId: postId)
            
        } catch {
            user = nil
            comments = []
            print(error.localizedDescription)
        }
    }
}
