//
//  RealmDiaryManager.swift
//  Dataiary
//
//  Created by 김민준 on 4/15/24.
//

import SwiftUI
import RealmSwift

final class RealmDiaryManager: DiaryManager {
    
    /// Realm
    private var realm = try! Realm()
}

// MARK: - Protocol Function
extension RealmDiaryManager {
    
    func fetchList() -> [Diary] {
        var diarys: [Diary] = []
        let result = realm.objects(RealmDiary.self).sorted(byKeyPath: "date", ascending: false)
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
        
        // Realm 데이터 생성
        guard let realmDiary = realm.object(ofType: RealmDiary.self, forPrimaryKey: diary.id) else {
            print(DiaryError.notFound)
            return
        }
        
        // Realm 데이터베이스 업데이트
        try? realm.write {
            realmDiary.date = diary.date
            realmDiary.content = diary.content
        }
    }
    
    func delete(for diary: Diary) {
        
        // Realm 데이터 생성
        guard let realmDiary = realm.object(ofType: RealmDiary.self, forPrimaryKey: diary.id) else {
            print(DiaryError.notFound)
            return
        }
        
        // Realm 데이터베이스 업데이트
        try? realm.write {
            realm.delete(realmDiary)
        }
    }
}
