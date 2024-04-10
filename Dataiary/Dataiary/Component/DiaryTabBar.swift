//
//  DiaryTabBar.swift
//  Dataiary
//
//  Created by 김민준 on 4/10/24.
//

import SwiftUI

struct DiaryTabBar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                TabBarCell(
                    selectedTab: $selectedTab,
                    title: tab.rawValue,
                    isActive: selectedTab == tab ? true : false
                )
            }
        }
    }
}

// MARK: - TabBarCell
private struct TabBarCell: View {
    
    @Binding var selectedTab: Tab
    
    let title: String
    let isActive: Bool
    
    var body: some View {
        VStack {
            Button {
                if let tab = Tab(rawValue: title) {
                    print(tab)
                    selectedTab = tab
                }
            } label: {
                Text(title)
                    .pretendard(.extraBold, 15)
                    .foregroundStyle(Color.main)
                    .frame(maxWidth: .infinity)
            }
            
            Rectangle()
                .foregroundStyle(Color.main)
                .frame(height: 2)
                .frame(maxWidth: .infinity)
        }
        .opacity(isActive ? 1 : 0.1)
    }
}

#Preview {
    DiaryTabBar(selectedTab: .constant(.coreData))
}
