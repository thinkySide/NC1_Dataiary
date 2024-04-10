//
//  WriteDiaryView.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI

struct WriteDiaryView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar()
        }
        .navigationBarBackButtonHidden()
    }
}

// MARK: - NavigationBar
private struct NavigationBar: View {
    
    @EnvironmentObject var pathModel: PathModel
    
    var body: some View {
        DiaryNavigationBar(
            title: Date().diaryFormat,
            leadingView: {
                Button("", image: .backIcon) {
                    pathModel.paths.removeLast()
                }
            },
            trailingView: {
                
            }
        )
    }
}

#Preview {
    WriteDiaryView()
}
