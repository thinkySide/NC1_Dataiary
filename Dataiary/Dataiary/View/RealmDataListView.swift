//
//  RealmDataListView.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI

struct RealmDataListView: View {
    
    @EnvironmentObject var pathModel: PathModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                
            }
            .padding(.top, 16)
            
            Spacer()
            
            DiaryActionButton(title: "add Realm diary.") {
                
            }
        }
        .background(Color.background)
    }
}

#Preview {
    RealmDataListView()
}
