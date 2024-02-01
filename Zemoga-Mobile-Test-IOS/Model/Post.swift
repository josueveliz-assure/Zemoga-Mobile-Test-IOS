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
}
