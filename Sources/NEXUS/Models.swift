import Foundation

struct Chat: Identifiable, Hashable {
    let id: Int
    let title: String
    let initials: String
    let lastMessage: String
    let time: String
    let unreadCount: Int
    let isPinned: Bool
    let isVerified: Bool
    let tint: String

    static let samples: [Chat] = [
        .init(id: 1, title: "NEXUS Community", initials: "N", lastMessage: "Добро пожаловать в NEXUS!", time: "18:24", unreadCount: 3, isPinned: true, isVerified: true, tint: "8B5CF6"),
        .init(id: 2, title: "Разработка iOS", initials: "i", lastMessage: "Новая сборка уже готова", time: "17:58", unreadCount: 1, isPinned: true, isVerified: false, tint: "06B6D4"),
        .init(id: 3, title: "Алексей", initials: "А", lastMessage: "Отправил файлы", time: "16:42", unreadCount: 0, isPinned: false, isVerified: false, tint: "F59E0B"),
        .init(id: 4, title: "Design Lab", initials: "D", lastMessage: "Выглядит очень круто ✨", time: "Вчера", unreadCount: 0, isPinned: false, isVerified: false, tint: "EC4899"),
        .init(id: 5, title: "Новости технологий", initials: "Т", lastMessage: "Обзор обновлений платформ", time: "Вчера", unreadCount: 12, isPinned: false, isVerified: false, tint: "10B981")
    ]
}

struct Contact: Identifiable {
    let id: Int
    let name: String
    let initials: String
    let status: String

    static let samples: [Contact] = [
        .init(id: 1, name: "Алексей", initials: "А", status: "был(а) недавно"),
        .init(id: 2, name: "Мария", initials: "М", status: "в сети"),
        .init(id: 3, name: "Даниил", initials: "Д", status: "был(а) сегодня")
    ]
}
