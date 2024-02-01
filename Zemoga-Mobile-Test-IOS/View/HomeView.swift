//
//  HomeView.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 1/2/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        CustomNavView {
            ZStack {
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
                    
                    InfiniteList()
                    
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
    HomeView()
}
