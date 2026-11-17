import SwiftUI

struct RootView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        ZStack {
            Color(hex: 0x090B13).ignoresSafeArea()
            Group {
                switch appState.selectedTab {
                case .chats: ChatsView()
                case .contacts: ContactsView()
                case .settings: SettingsView()
                }
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            HStack(spacing: 0) {
                ForEach(AppTab.allCases, id: \.self) { tab in
                    Button {
                        withAnimation(.spring(response: 0.32, dampingFraction: 0.82)) {
                            appState.selectedTab = tab
                        }
                    } label: {
                        VStack(spacing: 5) {
                            Image(systemName: tab.symbol).font(.system(size: 18, weight: .semibold))
                            Text(tab.rawValue).font(.system(size: 10, weight: .semibold))
                        }
                        .foregroundStyle(appState.selectedTab == tab ? .white : .white.opacity(0.42))
                        .frame(maxWidth: .infinity).padding(.vertical, 11)
                        .background {
                            if appState.selectedTab == tab {
                                Capsule().fill(appState.selectedTheme.gradient.opacity(0.22))
                                    .overlay(Capsule().stroke(.white.opacity(0.12), lineWidth: 1))
                            }
                        }
                    }.buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 18).padding(.top, 8).padding(.bottom, 4)
            .background(.ultraThinMaterial)
        }
    }
}
