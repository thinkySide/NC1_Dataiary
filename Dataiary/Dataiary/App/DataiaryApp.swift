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
    
    /// 전역적으로 사용할 SwiftData ModelContainer
    var sharedModelContainer: ModelContainer = {
        
        // 1. 데이터 폼 지정을 위한 Schema 생성
        let schema = Schema([SwiftDataDiary.self])
        
        // 2. Model 관리 규칙을 위한 ModelConfiguration 생성
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        // 3. ModelContainer 생성
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        // 4. ModelContainer 전역적으로 사용하기 위해 주입
        .modelContainer(sharedModelContainer)
    }
}
