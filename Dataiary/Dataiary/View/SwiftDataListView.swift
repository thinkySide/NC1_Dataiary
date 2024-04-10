//
//  SwiftDataListView.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI

struct SwiftDataListView: View {
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    
                }
                
                Spacer()
                
                DiaryActionButton(title: "add diary.") {
                    // TODO: 일기 작성 뷰 이동
                }
            }
        }
    }
}

#Preview {
    SwiftDataListView()
}
