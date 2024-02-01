//
//  ListPost2View.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 31/1/24.
//

import SwiftUI

struct ListPostView: View {
    var posts: [Post] = [
            Post(userID: 1, id: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "ut aspernatur corporis harum nihil quis provident sequi\nmollitia nobis aliquid molestiae\nperspiciatis et ea nemo ab reprehenderit accusantium quas\nvoluptate dolores velit et doloremque molestiae", isFavorite: true),
            Post(userID: 1, id: 2, title: "qui est esse", body: "ut aspernatur corporis harum nihil quis provident sequi\nmollitia nobis aliquid molestiae\nperspiciatis et ea nemo ab reprehenderit accusantium quas\nvoluptate dolores velit et doloremque molestiae", isFavorite: false),
            Post(userID: 1, id: 3, title: "ut aspernatur corporis harum nihil quis provident ", body: "ut aspernatur corporis harum nihil quis provident sequi\nmollitia nobis aliquid molestiae\nperspiciatis et ea nemo ab reprehenderit accusantium quas\nvoluptate dolores velit et doloremque molestiae", isFavorite: true),
            Post(userID: 1, id: 4, title: "eum et est occaecati", body: "ut aspernatur corporis harum nihil quis provident sequi\nmollitia nobis aliquid molestiae\nperspiciatis et ea nemo ab reprehenderit accusantium quas\nvoluptate dolores velit et doloremque molestiae", isFavorite: false),
            Post(userID: 1, id: 5, title: "nesciunt quas odio", body: "ut aspernatur corporis harum nihil quis provident sequi\nmollitia nobis aliquid molestiae\nperspiciatis et ea nemo ab reprehenderit accusantium quas\nvoluptate dolores velit et doloremque molestiae", isFavorite: false),
            Post(userID: 1, id: 6, title: "dolorem eum magni eos aperiam quia", body: "ut aspernatur corporis harum nihil quis provident sequi\nmollitia nobis aliquid molestiae\nperspiciatis et ea nemo ab reprehenderit accusantium quas\nvoluptate dolores velit et doloremque molestiae", isFavorite: true),
        ]
    
    var postDetail: Post = Post(userID: 1, id: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit sunt aut facere repellat provident occaecati excepturi optio reprehenderit sunt aut facere repellat provident occaecati excepturi optio reprehenderit", isFavorite: true)
    var userDetail: User = User(id: 1, name: "Josue", username: "josueveliz", email: "josue@gmail.com", address: Address(street: "street", suite: "suite", city: "city", zipcode: "zipcode", geo: Geo(lat: "lat", lng: "lng")), phone: "+592 69482428", website: "josueeliz.69.com", company: Company(name: "name", catchPhrase: "catchPhrase", bs: "bs"))
    var commentsDetail: [Comment] = [
        Comment(postID: 1, id: 1, name: "Josue", email: "jso@gmail.com", body: "Body sfsdf sdfqwsdf asdasd asq lorem asdad dfasd sdfsdf se q"),
        Comment(postID: 1, id: 2, name: "Josue", email: "asdf@gmail.com", body: "lorem asdad dfasd sdfsdf se q lorem asdad dfasd sdfsdf se q lorem a")
    ]
    
    @State private var selectedTab = 0
    
    var body: some View {
        CustomNavView {
            ZStack {
                Color.gray.opacity(0.1).ignoresSafeArea()
                
                VStack {
                    Picker("Tabs", selection: $selectedTab) {
                        Text("All").tag(0)
                        Text("Favorites").tag(1)
                    }
                    .padding(.top, 8)
                    .padding([.leading, .trailing])
                    .pickerStyle(.segmented)
                    .background(.gray.opacity(0.01))
                    .clipShape(RoundedRectangle(cornerRadius: 0))
                    
                    List(posts, id: \.id) { post in
                        CustomNavLinkView(
                            destination:
                                DetailPostView(post: postDetail, user: userDetail, comments: commentsDetail)
                                .customNavigationBackgroundColor("#27AE60")
                                .customNavigationForegroundColor("#FBFCFC")
                                .customNavigationTitle("Posts")
                                .customNavigationButtonProperties(ButtonProperties(systemImage: "star", action: {
                                    print("Action")
                                }))
                        ) {
                            RowPostView(post: post)
                                .swipeActions(edge: .trailing) {
                                    Button {
                                        print("Favorite")
                                    } label: {
                                        Label("Favorite", systemImage: "star")
                                    }
                                    .tint(.yellow)
                                }
                                .swipeActions(edge: .leading) {
                                    Button() {
                                        print("Delete")
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)
                                }
                        }
                        .padding(.vertical, 7)
                        
                    }
                    .listStyle(.plain)
                    
                    Button(action: {
                        print("Delete All")
                    }) {
                        Text("Delete All")
                            .font(.title2)
                    }
                    .padding(.top)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                }
            }
            .customNavigationTitle("Posts")
            .customNavigationBackButtonHidden(true)
            .customNavigationBackgroundColor("#27AE60")
            .customNavigationForegroundColor("#FBFCFC")
            .customNavigationButtonProperties(ButtonProperties(systemImage: "arrow.triangle.2.circlepath.circle", action: {
                print("Action")
            }))
        }
    }
}

#Preview {
    ListPostView()
}
