//
//  WriteDiaryView.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI

struct WriteDiaryView: View {
    
    @EnvironmentObject var pathModel: PathModel
    @State private var content: String = ""
    
    var body: some View {
        VStack(spacing: 12) {
            DiaryNavigationBar(
                title: Date().diaryFormat,
                leadingView: {
                    Button("", image: .backIcon) {
                        pathModel.paths.removeLast()
                    }
                },
                trailingView: {
                    Button {
                        // TODO: 일기 생성
                        pathModel.paths.removeLast()
                    } label: {
                        Text("done.")
                            .pretendard(.bold, 14)
                            .foregroundStyle(Color.main)
                    }
                    .opacity(content.isEmpty ? 0.3 : 1)
                    .disabled(content.isEmpty)
                }
            )
            
            DiaryTextField(contentText: $content)
            
            Spacer()
        }
        .background(Color.background)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    WriteDiaryView()
}
