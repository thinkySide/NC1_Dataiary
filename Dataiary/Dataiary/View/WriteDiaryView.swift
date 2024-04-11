//
//  WriteDiaryView.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI
import SwiftData

struct WriteDiaryView: View {
    
    @EnvironmentObject var pathModel: PathModel
    
    @Environment(\.modelContext) private var modelContext
    @Query private var diarys: [SwiftDataDiary]
    
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
                        create()
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
    
    func create() {
        // 1. Diary를 SwiftDataDiary로 변환
        let swiftDataDiary = SwiftDataDiary(
            id: UUID(),
            date: Date(),
            content: content
        )
        
        // 2. ModelContext를 이용해 삽입
        modelContext.insert(swiftDataDiary)
        
        // 3. 변경사항 저장
        try? modelContext.save()
    }
}

#Preview {
    WriteDiaryView()
}
