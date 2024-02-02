//
//  CustomNavBarView.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 31/1/24.
//

import SwiftUI

struct CustomNavBarView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let showBackButton: Bool
    let title: String
    let background: String
    let foreground: String
    let buttonProperties: ButtonProperties
    
    var body: some View {
        HStack {
            if showBackButton {
                backButton
            }else {
                backButton.hidden()
            }
            Spacer()
            titleSection
            Spacer()
            if buttonProperties.systemImage.isEmpty {
                actionButton.hidden()
            } else {
                actionButton
            }
            
        }
        .padding([.bottom, .trailing, .leading])
        .font(.headline)
        .foregroundColor(CustomColor(hex: foreground).color)
        .background(CustomColor(hex: background).color)
    }
}

#Preview {
    VStack {
        CustomNavBarView(showBackButton: true, title: "Posts", background: "#f2b31c", foreground: "#ffffff", buttonProperties: ButtonProperties(systemImage: "plus", action: {}))
        Spacer()
    }
}

extension CustomNavBarView {
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .font(.title)
        })
    }
    
    private var titleSection: some View {
        Text(LocalizedStringKey(title))
            .font(.title)
            .fontWeight(.semibold)
    }
    
    private var actionButton : some View {
        Button(action: {
            buttonProperties.action()
        }, label: {
            Image(systemName: buttonProperties.systemImage.isEmpty ? "star" : buttonProperties.systemImage)
                .resizable()
                .frame(width: 25, height: 25)
        })
    }
}
