import SwiftUI

struct ChatsView: View {
    @EnvironmentObject private var appState: AppState
    @State private var selectedChat: Chat?

    var body: some View {
        NavigationStack {
            VStack(spacing: 18) {
                ScreenHeader(title: "Сообщения", trailing: "DEMO")
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass").foregroundStyle(.white.opacity(0.45))
                    TextField("Поиск по чатам", text: $appState.searchText)
                        .foregroundStyle(.white).tint(.white)
                }
                .padding(13).background(.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 15))
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(appState.filteredChats) { chat in
                            Button { selectedChat = chat } label: {
                                ChatRow(chat: chat, theme: appState.selectedTheme)
                            }.buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding(.horizontal, 20).padding(.top, 14)
            .background(Color(hex: 0x090B13))
            .navigationDestination(item: $selectedChat) { chat in
                ChatDetailView(chat: chat)
            }
        }
        .tint(.white)
    }
}

struct ChatRow: View {
    let chat: Chat
    let theme: NEXUSTheme

    var body: some View {
        HStack(spacing: 13) {
            AvatarView(initials: chat.initials, colors: [Color(hexString: chat.tint), theme.colors.last ?? .blue], size: 54)
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 5) {
                    Text(chat.title).font(.system(size: 15, weight: .semibold)).foregroundStyle(.white)
                    if chat.isVerified { Image(systemName: "checkmark.seal.fill").font(.system(size: 12)).foregroundStyle(.cyan) }
                    Spacer()
                    Text(chat.time).font(.system(size: 11, weight: .medium)).foregroundStyle(.white.opacity(0.4))
                }
                HStack {
                    Text(chat.lastMessage).font(.system(size: 13)).foregroundStyle(.white.opacity(0.52)).lineLimit(1)
                    Spacer()
                    if chat.unreadCount > 0 {
                        Text("\(chat.unreadCount)").font(.system(size: 10, weight: .bold)).foregroundStyle(.white)
                            .padding(.horizontal, 7).padding(.vertical, 4).background(theme.gradient, in: Capsule())
                    }
                }
            }
        }
        .padding(12).background(.white.opacity(chat.isPinned ? 0.075 : 0.035), in: RoundedRectangle(cornerRadius: 19))
        .overlay(RoundedRectangle(cornerRadius: 19).stroke(.white.opacity(0.055), lineWidth: 1))
    }
}

struct ChatDetailView: View {
    let chat: Chat
    @State private var draft = ""
    @State private var messages = ["Добро пожаловать в NEXUS!", "Это демонстрационный экран. Подключение TDLib ещё не настроено."]
    var body: some View {
        VStack {
            HStack {
                AvatarView(initials: chat.initials, colors: [.purple, .cyan], size: 40)
                VStack(alignment: .leading) {
                    Text(chat.title).font(.headline).foregroundStyle(.white)
                    Text("Демонстрационный чат").font(.caption).foregroundStyle(.white.opacity(0.45))
                }
                Spacer()
            }.padding()
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(messages.enumerated()), id: \.offset) { _, message in
                        Text(message).foregroundStyle(.white).padding(12)
                            .background(.white.opacity(0.09), in: RoundedRectangle(cornerRadius: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }.padding()
            }
            HStack {
                TextField("Сообщение", text: $draft).textFieldStyle(.plain).foregroundStyle(.white)
                Button {
                    guard !draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
                    messages.append(draft); draft = ""
                } label: { Image(systemName: "arrow.up.circle.fill").font(.system(size: 30)).foregroundStyle(.cyan) }
            }.padding(12).background(.white.opacity(0.08), in: Capsule()).padding()
        }
        .background(Color(hex: 0x090B13)).toolbar(.hidden, for: .tabBar)
    }
}

extension Color {
    init(hexString: String) {
        let value = UInt(hexString, radix: 16) ?? 0x64748B
        self.init(hex: value)
    }
}
