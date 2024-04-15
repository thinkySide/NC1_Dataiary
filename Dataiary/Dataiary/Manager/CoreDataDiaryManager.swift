//
//  CoreDataDiaryManager.swift
//  Dataiary
//
//  Created by 김민준 on 4/15/24.
//

import Foundation
import CoreData

final class CoreDataDiaryManager: DiaryManager {
    
    /// CoreData 관리를 위한 NSManagedObjectContext
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
}

// MARK: - CoreData Function
extension CoreDataDiaryManager {
    
    /// CoreData Context를 저장합니다.
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("CoreData Error: \(error)")
        }
    }
    
    /// CoreDataDiary 타입을 Diary 타입으로 변환후 배열로 반환합니다.
    private func toDiarys(from coreDataDiarys: [CoreDataDiary]) -> [Diary] {
        var diarys: [Diary] = []
        for diary in coreDataDiarys {
            diarys.append(
                Diary(
                id: diary.id,
                date: diary.date,
                content: diary.content
                )
            )
        }
        return diarys
    }
}

// MARK: - Protocol Function
extension CoreDataDiaryManager {
    
    func fetchList() -> [Diary] {
        let fetchRequest = CoreDataDiary.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let coreDataDiarys = try context.fetch(fetchRequest)
            return toDiarys(from: coreDataDiarys)
        } catch {
            print(DiaryError.notFound)
            return []
        }
    }
    
    func create(_ diary: Diary) {
        
        // 새로운 CoreData 생성
        let coreDataDiary = CoreDataDiary(context: context)
        
        // 데이터 삽입
        coreDataDiary.id = diary.id
        coreDataDiary.date = diary.date
        coreDataDiary.content = diary.content
        
        // 저장
        saveContext()
    }
    
    func update(for diary: Diary) {
        //
    }
    
    func delete(for diary: Diary) {
        //
    }
}
