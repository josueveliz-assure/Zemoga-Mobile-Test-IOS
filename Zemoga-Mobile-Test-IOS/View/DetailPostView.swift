//
//  DetailPostView.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 30/1/24.
//

import SwiftUI

struct DetailPostView: View {
    var postContent: String
    var isFavorite: Bool
    var user: User
    var comments: [Comment]
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("detail-description")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.primary)
                Spacer()
            }
            .padding()
            
            Text("\(postContent)")
                .foregroundStyle(.primary)
                .padding([.leading, .trailing])
            
            
            HStack {
                Text("detail-user")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.primary)
                    .padding([.top, .leading])
                Spacer()
            }
            VStack(alignment: .leading) {
                HStack {
                    Text("\(user.name)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.leading)
                    Spacer()
                }
                HStack {
                    Text("\(user.email)")
                        .font(.body)
                        .foregroundColor(Color.black.opacity(0.7))
                        .padding(.leading)
                    Spacer()
                }
                HStack {
                    Text("\(user.phone)")
                        .fontWeight(.light)
                        .foregroundColor(Color.black.opacity(0.5))
                        .padding(.leading)
                    Spacer()
                }
                HStack {
                    if let url = URL(string: "http://\(user.website)") {
                        Link("\(user.website)", destination: url)
                            .underline()
                            .foregroundColor(.blue)
                            .padding(.leading)
                    }
                    Spacer()
                }
            }
            .padding([.leading, .trailing])
            .padding(.bottom, 10)
            
            HStack {
                Text("detail-comments")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .frame(maxHeight: 1)
                    .padding()
                Spacer()
            }
            .background(Color.gray.opacity(0.3))
            
            List(comments, id: \.id) { comment in
                Text("\(comment.body)")
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    DetailPostView(
        postContent: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit sunt aut facere repellat provident occaecati excepturi optio reprehenderit sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
        isFavorite: true,
        user: User(
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
        ),
        comments: []
    )
}
