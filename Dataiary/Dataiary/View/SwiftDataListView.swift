//
//  SwiftDataListView.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI
import SwiftData

struct SwiftDataListView: View {
    
    @EnvironmentObject var pathModel: PathModel
    
    @Environment(\.modelContext) private var modelContext
    @Query private var diarys: [SwiftDataDiary]
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                ForEach(diarys) { diary in
                    DiaryListCell(date: diary.date, content: diary.content)
                        .onTapGesture {
                            pathModel.paths.append(.read)
                        }
                }
            }
            .padding(.top, 16)
            
            Spacer()
            
            DiaryActionButton(title: "add diary.") {
                pathModel.paths.append(.write)
            }
        }
        .background(Color.background)
    }
}

#Preview {
    SwiftDataListView()
}
