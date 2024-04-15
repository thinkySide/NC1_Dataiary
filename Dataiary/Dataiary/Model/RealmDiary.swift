//
//  RealmDiary.swift
//  Dataiary
//
//  Created by 김민준 on 4/15/24.
//

import Foundation
import RealmSwift

class RealmDiary: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true)var id: UUID
    @Persisted var date: Date
    @Persisted var content: String
}
