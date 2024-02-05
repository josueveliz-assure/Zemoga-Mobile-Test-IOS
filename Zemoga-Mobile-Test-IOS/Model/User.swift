//
//  User.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 30/1/24.
//

import Foundation

struct User: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
    
    static let sample = [
        User(
            id: 1,
            name: "Josue",
            username: "Josue Veliz",
            email: "josue.vel@gmail.com",
            address: Address(
                street: "Street",
                suite: "Suite",
                city: "City",
                zipcode: "Zipcode",
                geo: Geo(
                    lat: "lat",
                    lng: "lng"
                )
            ),
            phone: "123456789",
            website: "www.zemoga.com",
            company: Company(
                name: "Zemoga",
                catchPhrase: "Catch Phrase",
                bs: "bs"
            )
        )
    ]
}

struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

struct Geo: Codable {
    let lat, lng: String
}

struct Company: Codable {
    let name, catchPhrase, bs: String
}
