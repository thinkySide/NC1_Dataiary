//
//  AppearanceToggleButton.swift
//  Dataiary
//
//  Created by 김민준 on 4/17/24.
//

import SwiftUI

struct AppearanceToggleButton: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @Binding var curretColorScheme: ColorScheme
    
    var body: some View {
        Button {
            curretColorScheme = colorScheme == .light ? .dark : .light
        } label: {
            Image(systemName: colorScheme == .light ? "moon.fill" : "sun.max.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(Color.main)
        }
        .animation(.bouncy, value: colorScheme)
    }
}

#Preview {
    AppearanceToggleButton(curretColorScheme: .constant(.light))
}
