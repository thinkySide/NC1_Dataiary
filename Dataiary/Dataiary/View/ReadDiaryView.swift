//
//  ReadDiaryView.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI

struct ReadDiaryView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var pathModel: PathModel
    @State private var content: String
    @State private var isEditMode = false
    @State private var isDeleteAlertPresented = false
    @FocusState private var isTextFieldFocus: Bool
    
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
                    Button("", image: colorScheme == .light ? .backIcon : .backIconDark) {
                        pathModel.paths.removeLast()
                    }
                },
                trailingView: {
                    if isEditMode {
                        Button {
                            isTextFieldFocus.toggle()
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
                        .opacity(content.isEmpty ? 0.3 : 1)
                        .disabled(content.isEmpty)
                    } else {
                        Menu("", image: colorScheme == .light ? .menuIcon : .menuIconDark) {
                            Button("delete.", role: .destructive) {
                                isDeleteAlertPresented.toggle()
                            }
                        }
                    }
                }
            )
            .alert("Do you want a delete?", isPresented: $isDeleteAlertPresented) {
                Button("cancel", role: .cancel) {}
                Button("delete", role: .destructive) {
                    diaryManager.delete(for: diary)
                    pathModel.paths.removeLast()
                }
            }
            
            DiaryTextField(
                contentText: $content,
                isTextFieldFocus: $isTextFieldFocus
            )
            .disabled(!isEditMode)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    isEditMode.toggle()
                    isTextFieldFocus.toggle()
                } label: {
                    Text("edit.")
                        .pretendard(.black, 24)
                        .foregroundStyle(Color.brand)
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
        diaryManager: SwiftDiaryManager(
            modelContext: MockModelContainer.mockModelContainer.mainContext
        ),
        diary: Diary(id: UUID(), date: Date(), content: "일기입니다.")
    )
    .environmentObject(PathModel())
}
