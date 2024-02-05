//
//  CustomNavBarPreferencesKeys.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 31/1/24.
//

import Foundation
import SwiftUI

struct CustomNavBarTitlePreferencesKeys: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct CustomNavBarBackButtonHiddenPreferencesKeys: PreferenceKey {
    
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

struct CustomNavBarBackgroundColorPreferencesKeys: PreferenceKey {
    
    static var defaultValue: String = "#27AE60"
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct CustomNavBarForegroundColorPreferencesKeys: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct CustomNavBarButtonPropertiesPreferencesKeys: PreferenceKey {
    
    static var defaultValue: ButtonProperties = ButtonProperties(systemImage: "", action: {})
    
    static func reduce(value: inout ButtonProperties, nextValue: () -> ButtonProperties) {
        value = nextValue()
    }
}


extension View {
    
    func customNavigationTitle(_ title: String) -> some View {
        preference(key: CustomNavBarTitlePreferencesKeys.self, value: title)
    }
    
    func customNavigationBackButtonHidden(_ hidden: Bool) -> some View {
        preference(key: CustomNavBarBackButtonHiddenPreferencesKeys.self, value: hidden)
    }
    
    func customNavigationBackgroundColor(_ color: String) -> some View {
        preference(key: CustomNavBarBackgroundColorPreferencesKeys.self, value: color)
    }
    
    func customNavigationForegroundColor(_ color: String) -> some View {
        preference(key: CustomNavBarForegroundColorPreferencesKeys.self, value: color)
    }
    
    func customNavigationButtonProperties(_ buttonProperties: ButtonProperties) -> some View {
        preference(key: CustomNavBarButtonPropertiesPreferencesKeys.self, value: buttonProperties)
    }
    
    func customNavBarItems(
        title: String = "",
        backButtonHidden: Bool = false,
        backgroundColor: String = "#27AE60",
        foregroundColor: String = "#FDFEFE",
        buttonProperties: ButtonProperties = ButtonProperties(systemImage: "", action: {})
    ) -> some View {
            self
                .customNavigationTitle(title)
                .customNavigationBackButtonHidden(backButtonHidden)
                .customNavigationBackgroundColor(backgroundColor)
                .customNavigationForegroundColor(foregroundColor)
                .customNavigationButtonProperties(buttonProperties)
    }
}
