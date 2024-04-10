//
//  DiaryNavigationBar.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI

struct DiaryNavigationBar<Leading: View, Trailing: View>: View {
    
    let title: String
    
    @ViewBuilder let leadingView: Leading
    @ViewBuilder let trailingView: Trailing
    
    private let navigationPadding: CGFloat = 16
    
    var body: some View {
        HStack {
            leadingView
                .padding(.leading, navigationPadding)
            
            Spacer()
            
            Text(title)
                .pretendard(.black, 12)
            
            Spacer()
            
            trailingView
                .padding(.trailing, navigationPadding)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 48)
    }
}

#Preview {
    DiaryNavigationBar(
        title: AppInfo.name,
        leadingView: {
            Button("", image: .backIcon) {}
        },
        trailingView: {
            Button("", image: .menuIcon) {}
        }
    )
}
