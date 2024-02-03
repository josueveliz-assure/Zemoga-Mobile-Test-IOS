//
//  ModelView.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 3/2/24.
//

import SwiftUI

struct ModalView<Content: View>: View {
    
    let content: Content
    let marginColor: Color
    
    @Binding var isShowing: Bool
    @State var curHeight: CGFloat = 400
    
    let minHeight: CGFloat = 400
    let maxHeight: CGFloat = 700
    
    init(isShowing: Binding<Bool>, marginColor: Color, @ViewBuilder content: () -> Content) {
        self._isShowing = isShowing
        self.marginColor = marginColor
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color
                    .black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                mainView
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeIn)
    }
    
    var mainView: some View {
        VStack {
            ZStack {
                Capsule()
                    .frame(width: 40, height: 6)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            
            ZStack {
                content
                    .padding([.leading, .trailing], 10)
            }
            .frame(maxHeight: curHeight)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                    Rectangle()
                        .frame(height: curHeight / 2)
                }
                    .foregroundStyle(marginColor)
            )
        }
    }
    
    @State private var prevDragTranslation = CGSize.zero
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { val in
                let dragAmount = val.translation.height - prevDragTranslation.height
                if curHeight > maxHeight || curHeight < minHeight {
                    curHeight -= dragAmount / 6
                } else {
                    curHeight -= dragAmount
                }
                prevDragTranslation = val.translation
            }
            .onEnded { val in
                prevDragTranslation = .zero
            }
    }
}

#Preview {
    ModalView(isShowing: .constant(true), marginColor: CustomColor(hex: "#f2f2f7").color) {
        CreatePostFormView()
    }
}
