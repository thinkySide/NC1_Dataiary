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
            VStack {
                Spacer()
                
                DiaryActionButton(title: "add diary.") {
                    
                }
            }
        }
    }
}

#Preview {
    SwiftDataListView()
}
