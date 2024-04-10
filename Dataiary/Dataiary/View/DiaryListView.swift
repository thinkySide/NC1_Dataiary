//
//  ContentView.swift
//  Dataiary
//
//  Created by 김민준 on 4/9/24.
//

import SwiftUI
import SwiftData

struct DiaryListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationStack {
            Text("프리텐다드 테스트")
                .pretendard(weight: .black, size: 28)
        }
    }
}

#Preview {
    DiaryListView()
        .modelContainer(for: Item.self, inMemory: true)
}
