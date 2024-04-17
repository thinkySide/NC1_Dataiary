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
            Text("화면 모드 전환")
        }
    }
}

#Preview {
    AppearanceToggleButton(curretColorScheme: .constant(.light))
}
