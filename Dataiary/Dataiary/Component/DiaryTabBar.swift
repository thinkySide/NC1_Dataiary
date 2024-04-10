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
        .background(Color.background)
    }
}

// MARK: - TabBarCell
private struct TabBarCell: View {
    
    @Binding var selectedTab: Tab
    
    let title: String
    let isActive: Bool
    
    var body: some View {
        Button {
            if let tab = Tab(rawValue: title) {
                print(tab)
                selectedTab = tab
            }
        } label: {
            VStack {
                Spacer()
                    .frame(height: 14)
                
                Text(title)
                    .pretendard(.extraBold, 15)
                    .foregroundStyle(Color.main)
                    .frame(maxWidth: .infinity)
                
                Spacer()
                
                Rectangle()
                    .foregroundStyle(Color.main)
                    .frame(height: 2)
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 48)
        .opacity(isActive ? 1 : 0.2)
        .animation(nil, value: selectedTab)
        
    }
}

#Preview {
    DiaryTabBar(selectedTab: .constant(.coreData))
}
