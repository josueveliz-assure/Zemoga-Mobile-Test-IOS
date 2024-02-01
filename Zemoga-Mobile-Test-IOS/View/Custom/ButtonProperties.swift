//
//  WrapperButton.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 31/1/24.
//

import Foundation
import SwiftUI

struct ButtonProperties: Equatable {
    let id = UUID()
    var systemImage: String
    var action: () -> Void
    
    init(systemImage: String, action: @escaping () -> Void) {
        self.systemImage = systemImage
        self.action = action
    }
    
    static func == (lhs: ButtonProperties, rhs: ButtonProperties) -> Bool {
        return lhs.id == rhs.id
    }
}
