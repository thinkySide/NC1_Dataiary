//
//  Diary.swift
//  Dataiary
//
//  Created by 김민준 on 4/11/24.
//

import Foundation

struct Diary: Identifiable {
    let id: UUID
    var date: Date
    var content: String
}
