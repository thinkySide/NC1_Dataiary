//
//  SwiftDataDiaryManager.swift
//  Dataiary
//
//  Created by 김민준 on 4/11/24.
//

import SwiftUI
import SwiftData

final class SwiftDataDiaryManager: DiaryManager {
    @Query private var diarys: [SwiftDataDiary]
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}

// MARK: - SwiftData Function
extension SwiftDataDiaryManager {
    
    /// SwiftData를 저장합니다.
    private func saveData() throws {
        do {
            try modelContext.save()
        } catch {
            throw DiaryError.cannotSave
        }
    }
}

// MARK: - Protocol Function
extension SwiftDataDiaryManager {
    
    func fetch(with index: Int) -> Diary {
        fatalError()
    }
    
    func fetchList() -> [Diary] {
        
        // 1. 최종 반환할 Diary 배열
        var diarys: [Diary] = []
        
        // 2. Date를 기준으로 Sorting 규칙 생성
        let sort = [SortDescriptor<SwiftDataDiary>(\.date, order: .forward)]
        
        // 3. FetchDescriptor 설정
        let descriptor = FetchDescriptor(sortBy: sort)
        
        // 4. ModelContext를 이용해 SwiftDataDiary 받아온 후 [Diary]로 변환
        do {
            let swiftDatas = try modelContext.fetch(descriptor)
            diarys = swiftDatas.map { Diary(id: $0.id, date: $0.date, content: $0.content) }
        } catch {
            // throw DiaryError.notFound
        }
        
        // 5. 최종 반환
        return diarys
    }
    
    func create(_ diary: Diary) {
        
        // 1. Diary를 SwiftDataDiary로 변환
        let swiftDataDiary = SwiftDataDiary(
            id: diary.id,
            date: diary.date,
            content: diary.content
        )
        
        // 2. ModelContext를 이용해 삽입
        modelContext.insert(swiftDataDiary)
        
        // 3. 변경사항 저장
        try? saveData()
    }
    
    func update(for diary: Diary) {
        //
    }
    
    func delete(for diary: Diary) {
        //
    }
}
