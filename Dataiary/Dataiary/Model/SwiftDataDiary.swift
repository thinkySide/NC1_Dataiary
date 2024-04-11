//
//  SwiftDataDiary.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import Foundation
import SwiftData

@Model
class SwiftDataDiary: Identifiable {
    let id: UUID
    let date: Date
    let content: String
    
    init(id: UUID, date: Date, content: String) {
        self.id = id
        self.date = date
        self.content = content
    }
}
