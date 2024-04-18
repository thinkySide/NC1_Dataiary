# NC1_Dataiary
**Apple Developer Academy @POSTECH**에서 진행한 Nano Challenge 1 프로젝트, Dataiary입니다.

![Cover](https://github.com/thinkySide/NC1_Dataiary/assets/113565086/92832cd4-c826-432e-85b8-a8fb3904d8f6)

## Overview
~~~swift
iOS에서 가장 많이 사용하는 3가지 로컬데이터 저장 방법으로 일기 작성하기 // CoreData, Realm, SwiftData
~~~

이번 Nano Challenge의 목표는 '나만의 다이어리앱을 만들면서 기본 하드스킬을 다지자!' 입니다.
2주라는 기간 내 실행 하기 위해서는 선택과 집중이 필요했고, 그렇게 선택하게 된 저만의 목표는 **'기본적인 일기 기능을 갖춘 앱을 만들되, 개발 실력을 향상할 수 있는 방법을 찾자'** 였습니다.
그 중 이번 메인 주제인 다이어리를 가장 잘 활용해볼 수 있는 로컬 데이터 저장 방식을 Deep-Dive 하기로 결정하게 되었습니다.

## UI Design & Flow

- 3가지 로컬 데이터 CoreData, Realm, SwiftData를 탭바로 전환할 수 있도록 구성했습니다.
- 기본적인 일기 기능 및 텍스트에 집중할 수 있도록 모노톤의 심플한 디자인을 채택했습니다.
- [🎨 Figma Link](https://www.figma.com/file/01CXkvTHbaIiXQ1oesnSfN/NC1_UI%EB%94%94%EC%9E%90%EC%9D%B8?type=design&node-id=0-1&mode=design&t=b1o8fPwIicPmNEq1-11) 

<img alt="Section 1" src="https://github.com/thinkySide/NC1_Dataiary/assets/113565086/d9f47855-b034-403d-8efa-e38fcb9abe0a">

## 프로젝트 포인트

프로젝트를 진행하며 해결했던 이슈, 알게 된 것들, 기억하고 싶은 순간들을 풀어 작성합니다.

### 1. 커스텀 탭바 구현하기

새로운 로컬데이터 저장 방식이 추가되거나 삭제되었을 때 대응할 수 있도록 컴포넌트를 구현했습니다.

- `Tab` 열거형에 `CaseIterable` 프로토콜을 채택해 그 수만큼 `TabBarCell`을 생성 및 데이터를 전달하고 있습니다.
- `TabBarCell`의 width는 `infinity` 로 구현되어 개수에 따라 가변적으로 크기를 변경할 수 있습니다.

~~~swift
enum Tab: String, CaseIterable {
    case coreData = "CoreData"
    case realm = "Realm"
    case swiftData = "SwiftData"
}
~~~

~~~swift
/// DiaryTabBar.swift

// MARK: - DiaryTabBar
struct DiaryTabBar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                TabBarCell(
                    selectedTab: $selectedTab,
                    title: tab.rawValue,
                    isActive: selectedTab == tab
                )
            }
        }
        .background(Color.background)
    }
}
~~~

~~~swift
// MARK: - TabBarCell
private struct TabBarCell: View {
    
    @Binding var selectedTab: Tab
    
    let title: String
    let isActive: Bool
    
    var body: some View {
        Button {
            if let tab = Tab(rawValue: title) {
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
    }
}
~~~

### 2. DiaryManager Protocol을 이용한 DIP

`DiaryManager` 프로토콜을 생성 후 3가지 로컬 데이터 저장 방식 모두 채택하게 해 View가 프로토콜을 의존할 수 있도록 방향을 역전시켰습니다.

- 각 로컬 데이터 저장 방식을 이용했을 때 같은 타입을 이용할 수 없어 공통적으로 View에서 사용할 수 있는 `Diary` struct를 생성했습니다.
- CoreDataDiaryManager, RealmDiaryManager, SwiftDiaryManager 는 모두 MainView에서 생성 후 주입하고 있습니다.
- ListDiaryView, WriteDiaryView, ReadDiaryView 뷰에서 모두 DiaryManager를 사용하고 있습니다.

~~~swift
/// Diary 관리를 위한 매니징 프로토콜
protocol DiaryManager: ObservableObject {
    
    /// Diary List를 반환합니다.
    func fetchList() -> [Diary]
    
    /// Diary를 생성합니다.
    func create(_ diary: Diary)
    
    /// Diary를 업데이트합니다.
    func update(for diary: Diary)
    
    /// Diary를 삭제합니다.
    func delete(for diary: Diary)
}
~~~

~~~swift
/// 3가지 로컬 데이터 저장을 관리할 수 있는 매니저에 채택
final class CoreDataDiaryManager: DiaryManager { ... }
final class RealmDiaryManager: DiaryManager { ... }
final class SwiftDiaryManager: DiaryManager { ... }

// MARK: - 실제 사용 부분 (ListDiaryView.swfit)
struct ListDiaryView: View {
    
    @EnvironmentObject var pathModel: PathModel
    @Binding var tab: Tab

    // 각각의 Manager를 생성할 때 넣어주기
    private let diaryManager: any DiaryManager
    
    init(diaryManager: any DiaryManager, tab: Binding<Tab>) {
        self.diaryManager = diaryManager
        self._tab = tab
    }
}
~~~

~~~swift
// MARK: - 생성 부분 (MainView.swift)
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
~~~

### 3. 커스텀 폰트 편하게 사용하기 위한 ViewModifier

Pretendard 폰트 사용을 편하게 하기 위해 커스텀 ViewModifier를 구현했습니다.

~~~swift
// MARK: - 구현부 (Helper+CustomFont)
struct PretendardModifier: ViewModifier {
    
    /// 프리텐다드 폰트 이름 열거형
    enum FontWeight: String {
        case thin = "Pretendard-Thin"
        case extraLight = "Pretendard-ExtraLight"
        case light = "Pretendard-Light"
        case regular = "Pretendard-Regular"
        case medium = "Pretendard-Medium"
        case semiBold = "Pretendard-SemiBold"
        case bold = "Pretendard-Bold"
        case extraBold = "Pretendard-ExtraBold"
        case black = "Pretendard-Black"
    }
    
    var weight: FontWeight
    var size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom(weight.rawValue, size: size))
    }
}

extension View {
    
    /// 프리텐다드 커스텀 폰트를 적용 후 반환합니다.
    func pretendard(_ weight: PretendardModifier.FontWeight, _ size: CGFloat) -> some View {
        modifier(PretendardModifier(weight: weight, size: size))
    }
}
~~~

~~~swift
// MARK: - 사용하기
Text("나는 한톨두톨세톨이에요")
    .pretendard(.bold, 17)
~~~
