//
//  ReadDiaryView.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI

struct ReadDiaryView: View {
    
    @EnvironmentObject var pathModel: PathModel
    @State private var content: String
    @State private var isEditMode = false
    
    private let diaryManager: any DiaryManager
    private var diary: Diary
    
    init(diaryManager: any DiaryManager, diary: Diary) {
        self.diaryManager = diaryManager
        self.diary = diary
        self._content = State(wrappedValue: diary.content)
    }
    
    var body: some View {
        VStack(spacing: 12) {
            DiaryNavigationBar(
                title: diary.date.diaryFormat,
                leadingView: {
                    Button("", image: .backIcon) {
                        pathModel.paths.removeLast()
                    }
                },
                trailingView: {
                    if isEditMode {
                        Button {
                            diaryManager.update(
                                for: Diary(
                                    id: diary.id,
                                    date: diary.date,
                                    content: content
                                )
                            )
                            isEditMode.toggle()
                        } label: {
                            Text("done.")
                                .pretendard(.bold, 14)
                                .foregroundStyle(Color.main)
                        }
                    } else {
                        Button("", image: .menuIcon) {
                            // TODO: 메뉴창 출력
                        }
                    }
                }
            )
            
            DiaryTextField(contentText: $content)
                .disabled(!isEditMode)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    isEditMode.toggle()
                } label: {
                    Text("edit.")
                        .pretendard(.black, 24)
                        .foregroundStyle(Color.main)
                }
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 16)
            .opacity(isEditMode ? 0 : 1)
        }
        .background(Color.background)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ReadDiaryView(
        diaryManager: SwiftDataDiaryManager(
            modelContext: MockModelContainer.mockModelContainer.mainContext
        ),
        diary: Diary(id: UUID(), date: Date(), content: "일기입니다.")
    )
    .environmentObject(
        PathModel()
    )
}
