//
//  DiaryTextField.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI

struct DiaryTextField: View {
    
    @Binding var contentText: String
    
    let placeholder: String = "일기를 작성해주세요."
    
    var body: some View {
        TextField(placeholder, text: $contentText)
            .pretendard(.regular, 17)
            .padding(.horizontal, 24)
    }
}

#Preview {
    DiaryTextField(contentText: .constant("DiaryTextField"))
}
