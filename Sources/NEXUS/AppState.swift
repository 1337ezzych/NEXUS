import SwiftUI

@MainActor
final class AppState: ObservableObject {
    @Published var selectedTab: AppTab = .chats
    @Published var selectedTheme: NEXUSTheme = .aurora
    @Published var searchText = ""
    @Published var chats: [Chat] = Chat.samples
    @Published var contacts: [Contact] = Contact.samples

    var filteredChats: [Chat] {
        guard !searchText.isEmpty else { return chats }
        return chats.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.lastMessage.localizedCaseInsensitiveContains(searchText)
        }
    }
}

enum AppTab: String, CaseIterable {
    case chats = "Чаты"
    case contacts = "Контакты"
    case settings = "Настройки"

    var symbol: String {
        switch self {
        case .chats: return "bubble.left.and.bubble.right.fill"
        case .contacts: return "person.2.fill"
        case .settings: return "slider.horizontal.3"
        }
    }
}
