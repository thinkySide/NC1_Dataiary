//
//  DiaryListCell.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI

struct DiaryListCell: View {
    
    let date: Date
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                Text(date.diaryFormat)
                    .pretendard(.black, 17)
                    .lineLimit(1)
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 2)
            }
            .padding(.leading, 24)
            
            Text(content)
                .pretendard(.regular, 16)
                .lineSpacing(16)
                .padding(.horizontal, 24)
        }
        .padding(.vertical, 24)
        .foregroundStyle(Color.main)
        .background(Color.background)
    }
}

#Preview {
    DiaryListCell(
        date: Date(),
        content: """
        명령·규칙 또는 처분이 헌법이나 법률에 위반되는 여부가 재판의 전제가 된 경우에는 대법원은 이를 최종적으로 심사할 권한을 가진다. 재판의 심리와 판결은 공개한다. 다만, 심리는 국가의 안전보장 또는 안녕질서를 방해하거나 선량한 풍속을 해할 염려가 있을 때에는 법원의 결정으로 공개하지 아니할 수 있다.
        """
    )
}
