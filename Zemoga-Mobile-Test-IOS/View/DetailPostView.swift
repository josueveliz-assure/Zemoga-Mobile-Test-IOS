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
    var userId: Int
    var postId: Int
    
    private var detailPostViewModel = DetailPostViewModel()
    
    init(postContent: String, isFavorite: Bool, userId: Int, postId: Int) {
        self.postContent = postContent
        self.isFavorite = isFavorite
        self.userId = userId
        self.postId = postId
    }
    
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
            
            Text("\(postContent)")
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
                    Text("\(detailPostViewModel.user?.name ?? "")")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.leading)
                    Spacer()
                }
                HStack {
                    Text("\(detailPostViewModel.user?.email ?? "")")
                        .font(.body)
                        .foregroundColor(Color.black.opacity(0.7))
                        .padding(.leading)
                    Spacer()
                }
                HStack {
                    Text("\(detailPostViewModel.user?.phone ?? "")")
                        .fontWeight(.light)
                        .foregroundColor(Color.black.opacity(0.5))
                        .padding(.leading)
                    Spacer()
                }
                HStack {
                    if let url = URL(string: "http://\(detailPostViewModel.user?.website ?? "")") {
                        Link("\(detailPostViewModel.user?.website ?? "")", destination: url)
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
            
            List(detailPostViewModel.comments, id: \.id) { comment in
                Text("\(comment.body)")
            }
            .listStyle(.plain)
        }
        .redactShimmer(condition: detailPostViewModel.isLoading)
        .task {
            await detailPostViewModel.getDetailData(userId: userId, postId: postId)
        }
    }
}

#Preview {
    DetailPostView(
        postContent: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit sunt aut facere repellat provident occaecati excepturi optio reprehenderit sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
        isFavorite: true,
        userId: 1,
        postId: 1
    )
}
