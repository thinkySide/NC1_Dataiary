//
//  DiaryActionButton.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI

struct DiaryActionButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Text(title)
            .pretendard(.black, 16)
            .foregroundStyle(Color.background)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.main)
            .onTapGesture {
                action()
            }
    }
}

#Preview {
    DiaryActionButton(title: "Action Button") {}
}
