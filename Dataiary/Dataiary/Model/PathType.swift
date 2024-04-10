//
//  PathModel.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import Foundation

enum PathType {
    case write
    case read
}

final class PathModel: ObservableObject {
    @Published var paths: [PathType] = []
}
