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
                
            }
            
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
