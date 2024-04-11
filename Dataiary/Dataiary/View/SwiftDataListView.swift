//
//  SwiftDataListView.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI

struct SwiftDataListView: View {
    
    @EnvironmentObject var pathModel: PathModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                DiaryListCell(date: Date(), content: "안녕하세요, 일기입니다.")
                    .onTapGesture {
                        pathModel.paths.append(.read)
                    }
            }
            .padding(.top, 40)
            
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
