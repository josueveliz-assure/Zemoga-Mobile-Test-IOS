//
//  CreatePostFormView.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 3/2/24.
//

import SwiftUI

struct CreatePostFormView: View {
    @State private var postTitle: String = ""
    @State private var postContent: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Post Content")) {
                    TextField("Title", text: $postTitle)
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $postContent)
                            .frame(height: 150)
                        if postContent.isEmpty {
                            Text("Content")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                .padding(.leading, 4)
                        }
                    }
                }
            }
            .tint(CustomColor(hex: "#27AE60").color)
            .navigationTitle("Post")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Save")
                    }) {
                        Text("Save")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing, 10)
                    .padding(.leading, 6)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .padding(.top)
    }
}

#Preview {
    CreatePostFormView()
}
