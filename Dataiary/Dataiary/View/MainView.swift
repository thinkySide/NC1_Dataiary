//
//  MainView.swift
//  Dataiary
//
//  Created by 김민준 on 4/9/24.
//

import SwiftUI

struct MainView: View {
    
    /// Navigation Path를 관리하는 모델
    @StateObject private var pathModel: PathModel = .init()
    
    /// 현재 선택된 Tab
    @State private var selectedTab: Tab = .swiftData
    
    /// SwiftData에서 사용할 ModelContext
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            VStack(spacing: 0) {
                DiaryNavigationBar(
                    title: AppInfo.name,
                    leadingView: {},
                    trailingView: {}
                )
                
                DiaryTabBar(selectedTab: $selectedTab)
                
                DataTabView(
                    swiftDataDiarymanager: SwiftDataDiaryManager(modelContext: modelContext),
                    selectedTab: $selectedTab
                )
            }
            .background(Color.background)
        }
        .environmentObject(pathModel)
    }
}

// MARK: - DataTabView
private struct DataTabView: View {
    
    @StateObject var swiftDataDiarymanager: SwiftDataDiaryManager
    @Binding var selectedTab: Tab
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CoreDataListView()
                .tag(Tab.coreData)
            
            RealmDataListView()
                .tag(Tab.realm)
            
            SwiftDataListView()
                .tag(Tab.swiftData)
                .environmentObject(swiftDataDiarymanager)
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .navigationDestination(for: PathType.self) { path in
            switch path {
            case .read(let diaryManager, let diary):
                ReadDiaryView(diaryManager: diaryManager, diary: diary)
                
            case .write(let diaryManager):
                WriteDiaryView(diaryManager: diaryManager)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    MainView()
        .modelContainer(MockModelContainer.mockModelContainer)
        .environmentObject(PathModel())
}
