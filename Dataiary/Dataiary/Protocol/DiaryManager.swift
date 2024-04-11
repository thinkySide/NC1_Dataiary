//
//  DiaryManager.swift
//  Dataiary
//
//  Created by 김민준 on 4/11/24.
//

import Foundation

/// Diary 관리를 위한 매니징 프로토콜
protocol DiaryManager {
    
    /// Diary를 반환합니다.
    func fetch(with index: Int) -> Diary
    
    /// Diary List를 반환합니다.
    func fetchList() throws -> [Diary]
    
    /// Diary를 생성합니다.
    func create(_ diary: Diary)
    
    /// Diary를 업데이트합니다.
    func update(for diary: Diary)
    
    /// Diary를 삭제합니다.
    func delete(for diary: Diary)
}

/// Diary 매니저가 발생시킬 수 있는 에러
enum DiaryError: Error {
    case notFound // 데이터 찾을 수 없음
    case cannotSave // 저장할 수 없음
}
