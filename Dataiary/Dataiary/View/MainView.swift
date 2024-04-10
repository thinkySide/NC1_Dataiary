//
//  MainView.swift
//  Dataiary
//
//  Created by 김민준 on 4/9/24.
//

import SwiftUI

struct MainView: View {
    
    /// Navigation Path를 관리하는 모델
    @StateObject private var pathModel = PathModel()
    
    /// 현재 선택된 Tab
    @State private var selectedTab: Tab = .swiftData
    
    var body: some View {
        NavigationStack(path: $pathModel.paths) {
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
            .background(Color.main)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .navigationDestination(for: PathType.self) { path in
                switch path {
                case .read:
                    EmptyView()
                    
                case .write:
                    WriteDiaryView()
                }
            }
        }
        .environmentObject(pathModel)
    }
}

#Preview {
    MainView()
}
