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
            
        }
    }
}

#Preview {
    DiaryListView()
        .modelContainer(for: Item.self, inMemory: true)
}
