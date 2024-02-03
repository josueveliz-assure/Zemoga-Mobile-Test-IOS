//
//  ApiManager.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 30/1/24.
//

import Foundation
import Alamofire

class ApiManager {
    static let shared = ApiManager()
    private let endpoint = "https://jsonplaceholder.typicode.com"
    
    var isConnected: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    private func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<T, Error>) -> Void)
    {
        guard isConnected else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No internet connection"])))
            return
        }
        
        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPosts(page: Int, limit: Int, completion: @escaping (Result<[Post], Error>) -> Void) {
        let url = "\(endpoint)/posts?_page=\(page)&_limit=\(limit)"
        request(url: url, completion: completion)
    }
    
    func getComments(postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        let url = "\(endpoint)/posts/\(postId)/comments"
        request(url: url, completion: completion)
    }
    
    func getUser(userId: Int, completion: @escaping (Result<User, Error>) -> Void) {
        let url = "\(endpoint)/users/\(userId)"
        request(url: url, completion: completion)
    }
    
    func removePost(postId: Int, completion: @escaping (Result<EmptyResponse, Error>) -> Void) {
        let url = "\(endpoint)/posts/\(postId)"
        request(url: url, method: .delete, completion: completion)
    }
    
    func addPost(post: NewPost, completion: @escaping (Result<Post, Error>) -> Void) {
        let url = "\(endpoint)/posts"
        let headers: HTTPHeaders = ["Content-type": "application/json; charset=UTF-8"]
        let parameters = ["title": post.title, "body": post.body, "userId": post.userID] as [String : Any]
        
        request(url: url, method: .post, parameters: parameters, headers: headers, completion: completion)
    }
}

struct EmptyResponse: Decodable {}
