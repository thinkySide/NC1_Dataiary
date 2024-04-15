//
//  RealmDiaryManager.swift
//  Dataiary
//
//  Created by 김민준 on 4/15/24.
//

import SwiftUI
import RealmSwift

final class RealmDiaryManager: DiaryManager {
    
    /// Diary 배열
    @Published private var diarys: [Diary] = []
    
    /// Realm
    private var realm = try! Realm()
}

// MARK: - Protocol Function
extension RealmDiaryManager {
    
    func fetchList() -> [Diary] {
        var diarys: [Diary] = []
        let result = realm.objects(RealmDiary.self)
        for realmDairy in result {
            diarys.append(
                Diary(
                    id: realmDairy.id,
                    date: realmDairy.date,
                    content: realmDairy.content
                )
            )
        }
        return diarys
    }
    
    func create(_ diary: Diary) {
        
        // Realm 데이터 생성
        let realmDiary = RealmDiary()
        realmDiary.id = diary.id
        realmDiary.date = diary.date
        realmDiary.content = diary.content
        
        // Realm 데이터베이스에 추가
        try? realm.write {
            realm.add(realmDiary)
        }
    }
    
    func update(for diary: Diary) {
        //
    }
    
    func delete(for diary: Diary) {
        //
    }
}
