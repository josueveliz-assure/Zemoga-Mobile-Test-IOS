//
//  AppNavBarView.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 31/1/24.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color.orange.ignoresSafeArea()
                
                List {
                    CustomNavLinkView(
                        destination: Text("Destination").customNavigationTitle("Posts")) {
                            Text("Navigate")
                        }
                }.listStyle(.plain)
            }
            .customNavigationTitle("Posts")
            .customNavigationBackButtonHidden(true)
            .customNavigationBackgroundColor("#27AE60")
            
        }
    }
}

#Preview {
    AppNavBarView()
}
