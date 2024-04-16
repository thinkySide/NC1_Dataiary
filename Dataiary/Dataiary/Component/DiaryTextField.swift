//
//  DiaryTextField.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI

struct DiaryTextField: View {
    
    @Binding var contentText: String
    @FocusState.Binding var isTextFieldFocus: Bool
    
    let placeholder: String = "일기를 작성해주세요."
    
    var body: some View {
        TextField(placeholder, text: $contentText, axis: .vertical)
            .pretendard(.regular, 17)
            .padding(.horizontal, 24)
            .focused($isTextFieldFocus)
            .lineSpacing(contentText.isEmpty ? 0 : 16)
    }
}

#Preview {
    @FocusState var isTextFieldFocus
    return DiaryTextField(
        contentText: .constant(""),
        isTextFieldFocus: $isTextFieldFocus
    )
}
