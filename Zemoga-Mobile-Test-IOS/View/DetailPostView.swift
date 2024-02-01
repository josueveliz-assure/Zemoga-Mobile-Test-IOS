//
//  DetailPostView.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 30/1/24.
//

import SwiftUI

struct DetailPostView: View {
    var post: Post
    var user: User
    var comments: [Comment]
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Description")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.primary)
                Spacer()
            }
            .padding()
            
            Text("\(post.body)")
                .foregroundStyle(.primary)
            
            
            HStack {
                Text("User")
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
                Text("Comments")
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
        post: Post(userID: 1, id: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit sunt aut facere repellat provident occaecati excepturi optio reprehenderit sunt aut facere repellat provident occaecati excepturi optio reprehenderit", isFavorite: true),
        user: User(id: 1, name: "Josue", username: "josueveliz", email: "josue@gmail.com", address: Address(street: "street", suite: "suite", city: "city", zipcode: "zipcode", geo: Geo(lat: "lat", lng: "lng")), phone: "phone", website: "website", company: Company(name: "name", catchPhrase: "catchPhrase", bs: "bs")),
        comments: [
            Comment(postID: 1, id: 1, name: "Josue", email: "jso@gmail.com", body: "Body sfsdf sdfqwsdf asdasd asq lorem asdad dfasd sdfsdf se q"),
            Comment(postID: 1, id: 2, name: "Josue", email: "asdf@gmail.com", body: "lorem asdad dfasd sdfsdf se q lorem asdad dfasd sdfsdf se q lorem a")
        ]
    )
}
