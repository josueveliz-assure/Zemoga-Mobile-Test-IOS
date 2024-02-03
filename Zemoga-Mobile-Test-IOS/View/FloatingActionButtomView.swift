//
//  FloatingActionButtomView.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 2/2/24.
//

import SwiftUI

struct FloatingActionButtomView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .frame(width: 70, height: 70)
                        .background(CustomColor(hex: "#27AE60").color)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.white)
                })
                .padding()
                .shadow(color: .gray.opacity(0.7), radius: 5, x: 5, y: 5)
            }
        }
    }
}

#Preview {
    FloatingActionButtomView()
}
