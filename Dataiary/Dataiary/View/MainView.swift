//
//  MainView.swift
//  Dataiary
//
//  Created by 김민준 on 4/9/24.
//

import SwiftUI

struct MainView: View {
    
    /// CoreData에서 사용할 NSManagedObjectContext
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    /// SwiftData에서 사용할 ModelContext
    @Environment(\.modelContext) private var modelContext
    
    /// Navigation Path를 관리하는 모델
    @StateObject private var pathModel: PathModel = .init()
    
    /// 현재 선택된 Tab
    @State private var selectedTab: Tab = .coreData
    
    /// 화면 모드 전환용 ColorScheme
    @State private var colorScheme: ColorScheme = .light
    
    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            VStack(spacing: 0) {
                DiaryNavigationBar(
                    title: AppInfo.name,
                    leadingView: {},
                    trailingView: {
                        AppearanceToggleButton(curretColorScheme: $colorScheme)
                    }
                )
                
                DiaryTabBar(selectedTab: $selectedTab)
                
                DataTabView(
                    coreDataDiaryManager: CoreDataDiaryManager(context: managedObjectContext),
                    swiftDataDiarymanager: SwiftDiaryManager(modelContext: modelContext),
                    selectedTab: $selectedTab
                )
            }
            .background(Color.background)
        }
        .environmentObject(pathModel)
        .preferredColorScheme(colorScheme)
    }
}

// MARK: - DataTabView
private struct DataTabView: View {
    
    @StateObject var coreDataDiaryManager: CoreDataDiaryManager
    @StateObject var realDataDiaryManager: RealmDiaryManager = .init()
    @StateObject var swiftDataDiarymanager: SwiftDiaryManager
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ListDiaryView(
                diaryManager: coreDataDiaryManager,
                tab: $selectedTab
            )
            .tag(Tab.coreData)
            
            ListDiaryView(
                diaryManager: realDataDiaryManager,
                tab: $selectedTab
            )
            .tag(Tab.realm)
            
            ListDiaryView(
                diaryManager: swiftDataDiarymanager,
                tab: $selectedTab
            )
            .tag(Tab.swiftData)
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
        .environmentObject(PathModel())
        .modelContainer(MockModelContainer.mockModelContainer)
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
