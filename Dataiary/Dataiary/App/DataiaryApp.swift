//
//  DataiaryApp.swift
//  Dataiary
//
//  Created by 김민준 on 4/9/24.
//

import SwiftUI
import SwiftData

@main
struct DataiaryApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        // .modelContainer(sharedModelContainer)
    }
}
