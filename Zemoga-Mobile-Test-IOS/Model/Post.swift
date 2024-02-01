//
//  Post.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 30/1/24.
//

import Foundation

struct Post: Codable {
    let userID, id: Int
    let title, body: String
    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
    
    static let sample: [Post] = [
        Post(userID: 1, id: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "ut aspernatur corporis harum nihil quis provident sequi\nmollitia nobis aliquid molestiae", isFavorite: true),
        Post(userID: 1, id: 2, title: "qui est esse", body: "ut aspernatur corporis harum nihil quis provident sequi\nmollitia nobis aliquid molestiae\nperspiciatis et ea nemo ab ", isFavorite: false),
        Post(userID: 1, id: 3, title: "ut aspernatur corporis harum nihil quis provident ", body: "ut aspernatur corporis harum nihil quis provident sequi\nmollitia nobis aliquid molestiae\nperspiciatis et ea nemo ab reprehenderit accusantium quas\nvoluptate dolores velit et doloremque molestiae", isFavorite: true),
        Post(userID: 1, id: 4, title: "eum et est occaecati", body: "ut aspernatur corporis harum nihil quis provident sequi\nmollitia nobis aliquid molestiae\nperspiciatis et ea nemo ab reprehenderit accusantium quas\nvoluptate dolores velit et doloremque molestiae", isFavorite: false),
        Post(userID: 1, id: 5, title: "nesciunt quas odio", body: "nobis aliquid molestiae\nperspiciatis et ea nemo ab reprehenderit accusantium quas\nvoluptate dolores velit et doloremque molestiae", isFavorite: false),
        Post(userID: 1, id: 6, title: "dolorem eum magni eos aperiam quia", body: "ut aspernatur corporis harum nihil quis provident sequi\nmollitia nobis et doloremque molestiae", isFavorite: true),
    ]
}
