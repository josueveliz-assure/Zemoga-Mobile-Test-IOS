//
//  CustomColor.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 31/1/24.
//

import Foundation
import SwiftUI

struct CustomColor{
    var hex: String {
        didSet {
            self.color = Color(hex: hex)
        }
    }
    
    var color: Color
    
    init(hex: String) {
        self.hex = hex
        self.color = Color(hex: hex)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3:
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255.0,
            green: Double(g) / 255.0,
            blue:  Double(b) / 255.0,
            opacity: 1
        )
    }
}
