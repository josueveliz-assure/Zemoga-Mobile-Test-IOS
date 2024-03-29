//
//  RedactedShimerViewModifier.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 1/2/24.
//

import SwiftUI
import Foundation
import Shimmer

public struct RedactAndShimmerViewModifier: ViewModifier {
  private let condition: Bool
  
  
  init(condition: Bool) {
    self.condition = condition
  }
  
  public func body(content: Content) -> some View {
    if condition {
      content
        .redacted(reason: .placeholder)
        .shimmering()
    } else {
     content
    }
  }
}


extension View {
  public func redactShimmer(condition: Bool) -> some View {
    modifier(RedactAndShimmerViewModifier(condition: condition))
  }
}
