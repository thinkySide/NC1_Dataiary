//
//  WriteDiaryView.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI
import SwiftData

struct WriteDiaryView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var pathModel: PathModel
    @State private var content: String = ""
    @FocusState private var isTextFieldFocus: Bool
    
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
                    Button("", image: colorScheme == .light ? .backIcon : .backIconDark) {
                        pathModel.paths.removeLast()
                    }
                },
                trailingView: {
                    Button {
                        diaryManager.create(
                            Diary(
                                id: UUID(),
                                date: creationDate,
                                content: content
                            )
                        )
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
            
            DiaryTextField(
                contentText: $content,
                isTextFieldFocus: $isTextFieldFocus
            )
            
            Spacer()
        }
        .background(Color.background)
        .navigationBarBackButtonHidden()
        .onAppear {
            isTextFieldFocus = true
        }
    }
}

#Preview {
    WriteDiaryView(
        diaryManager: SwiftDiaryManager(
            modelContext: MockModelContainer.mockModelContainer.mainContext
        )
    )
    .environmentObject(PathModel())
}
