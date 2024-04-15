//
//  RealmDataListView.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI

struct RealmDataListView: View {
    
    @EnvironmentObject var pathModel: PathModel
    @StateObject var diaryManager: RealmDiaryManager = .init()
    
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
            
            DiaryActionButton(title: "add Realm diary.") {
                pathModel.paths.append(.write(diaryManager: diaryManager))
            }
        }
        .background(Color.background)
    }
}

#Preview {
    RealmDataListView()
}
