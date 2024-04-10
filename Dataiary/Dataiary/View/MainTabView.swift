//
//  MainTabView.swift
//  Dataiary
//
//  Created by 김민준 on 4/9/24.
//

import SwiftUI

struct MainTabView: View {
    
    /// 현재 선택된 Tab
    @State var selectedTab: Tab = .coreData
    
    var body: some View {
        VStack(spacing: 0) {
            DiaryNavigationBar(
                title: AppInfo.name,
                leadingView: {},
                trailingView: {}
            )
            
            DiaryTabBar(selectedTab: $selectedTab)
            
            TabView(selection: $selectedTab) {
                CoreDataListView()
                    .tag(Tab.coreData)
                
                RealmDataListView()
                    .tag(Tab.realm)
                
                SwiftDataListView()
                    .tag(Tab.swiftData)
            }
        }
        .background(Color.background)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

#Preview {
    MainTabView()
}
