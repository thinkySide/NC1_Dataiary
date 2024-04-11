//
//  MockModelContainer.swift
//  Dataiary
//
//  Created by 김민준 on 4/11/24.
//

import Foundation
import SwiftData

struct MockModelContainer {
    
    /// 목업용으로 사용할 SwiftData ModelContainer
    static var mockModelContainer: ModelContainer = {
        let schema = Schema([SwiftDataDiary.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            return container
        } catch {
            fatalError("Could not create MockModelContainer: \(error)")
        }
    }()
}
