//
//  CustomNavBarContainerView.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 31/1/24.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    
    let content: Content
    @State private var showBackButton: Bool = true
    @State private var title: String = ""
    @State private var background: String = ""
    @State private var foreground: String = ""
    @State private var buttonProperties: ButtonProperties = ButtonProperties(systemImage: "", action: {})
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(
                showBackButton: showBackButton,
                title: title,
                background: background,
                foreground: foreground,
                buttonProperties: buttonProperties
            )
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .onPreferenceChange(CustomNavBarTitlePreferencesKeys.self) { value in
            title = value
        }
        .onPreferenceChange(CustomNavBarBackButtonHiddenPreferencesKeys.self) { value in
            showBackButton = !value
        }
        .onPreferenceChange(CustomNavBarBackgroundColorPreferencesKeys.self) {
            value in
                background = value
        }
        .onPreferenceChange(CustomNavBarForegroundColorPreferencesKeys.self) {
            value in
                foreground = value
        }
        .onPreferenceChange(CustomNavBarButtonPropertiesPreferencesKeys.self) {
            value in
                buttonProperties = value
        }
    }
}

#Preview {
    CustomNavBarContainerView() {
        ZStack {
            Color.red.ignoresSafeArea()
            
            Text("Hello")
            
                .customNavigationTitle("Posts")
                .customNavigationBackgroundColor("#27AE60")
                .customNavigationForegroundColor("ffffff")
                .customNavigationButtonProperties(ButtonProperties(systemImage: "star", action: {
                    print("Action")
                }))
        }
    }
}
