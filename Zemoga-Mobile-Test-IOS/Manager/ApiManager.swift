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
    
    private func request<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard isConnected else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No internet connection"])))
            return
        }
        
        AF.request(url).validate().responseDecodable(of: T.self) { response in
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
}
