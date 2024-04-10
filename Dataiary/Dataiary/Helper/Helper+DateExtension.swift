//
//  Helper+DateExtension.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import Foundation

extension Date {
    
    /// Date 타입을 다음 포맷으로 변환 후 반환합니다.
    /// 24.04.10 WED
    var diaryFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY.MM.dd EEE"
        let dateString = dateFormatter.string(from: self)
        return dateString.uppercased()
    }
}
