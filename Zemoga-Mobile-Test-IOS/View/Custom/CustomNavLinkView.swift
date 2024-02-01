//
//  CustomNavLinkView.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 31/1/24.
//

import SwiftUI

struct CustomNavLinkView<Label:View, Destination:View> : View {
    
    let destination: Destination
    let label: Label
    
    init(destination: Destination, @ViewBuilder label : () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        NavigationLink(
            destination:
                CustomNavBarContainerView(content: {
                    destination
                })
                .toolbar(.hidden)
            ,
            label: {
                label
            })
    }
}

#Preview {
    CustomNavView{
        CustomNavLinkView(
            destination: Text("Destination")) {
                Text("Navigate")
            }
    }
}
