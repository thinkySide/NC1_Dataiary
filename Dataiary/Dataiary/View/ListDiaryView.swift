//
//  ListDiaryView.swift
//  Dataiary
//
//  Created by 김민준 on 4/15/24.
//

import SwiftUI

struct ListDiaryView: View {
    
    @EnvironmentObject var pathModel: PathModel
    
    private let diaryManager: any DiaryManager
    
    init(diaryManager: any DiaryManager) {
        self.diaryManager = diaryManager
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                ForEach(diaryManager.fetchList()) { diary in
                    DiaryListCell(
                        date: diary.date,
                        content: diary.content
                    )
                    .onTapGesture {
                        pathModel.paths.append(
                            .read(
                                diaryManager: diaryManager,
                                diary: diary
                            )
                        )
                    }
                }
            }
            .padding(.top, 16)
            
            Spacer()
            
            DiaryActionButton(title: "add SwiftData diary.") {
                pathModel.paths.append(.write(diaryManager: diaryManager))
            }
        }
        .background(Color.background)
    }
}

#Preview {
    ListDiaryView(
        diaryManager: SwiftDiaryManager(
            modelContext: MockModelContainer.mockModelContainer.mainContext
        )
    )
}
