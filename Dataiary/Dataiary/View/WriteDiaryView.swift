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
    @State private var content: String = ""
    
    private let diaryManager: any DiaryManager
    
    let creationDate = Date()
    
    init(diaryManager: any DiaryManager) {
        self.diaryManager = diaryManager
    }
    
    var body: some View {
        VStack(spacing: 12) {
            DiaryNavigationBar(
                title: creationDate.diaryFormat,
                leadingView: {
                    Button("", image: .backIcon) {
                        pathModel.paths.removeLast()
                    }
                },
                trailingView: {
                    Button {
                        diaryManager.create(Diary(id: UUID(), date: creationDate, content: content))
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
    WriteDiaryView(
        diaryManager: SwiftDataDiaryManager(
            modelContext: MockModelContainer.mockModelContainer.mainContext
        )
    )
    .environmentObject(PathModel())
}
