//
//  PathModel.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import Foundation

/// Navigation Path 타입 열거형
enum PathType: Hashable {
    case read(diaryManager: any DiaryManager, diary: Diary)
    case write(diaryManager: any DiaryManager)
}

// MARK: - Hashable 프로토콜 준수를 위한 메서드 구현
extension PathType {
    static func == (lhs: PathType, rhs: PathType) -> Bool { return true }
    func hash(into hasher: inout Hasher) {}
}

final class PathModel: ObservableObject {
    @Published var paths: [PathType] = []
}
