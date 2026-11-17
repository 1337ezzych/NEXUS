import SwiftUI

struct NEXUSTheme: Identifiable, Hashable {
    let id: String
    let name: String
    let subtitle: String
    let colors: [Color]

    static let all: [NEXUSTheme] = [.aurora, .obsidian, .arctic, .sakura, .emerald, .solarFlare]
    static let aurora = NEXUSTheme(id: "aurora", name: "Aurora", subtitle: "Северное сияние", colors: [Color(hex: 0x7C3AED), Color(hex: 0x06B6D4)])
    static let obsidian = NEXUSTheme(id: "obsidian", name: "Obsidian", subtitle: "Глубокий графит", colors: [Color(hex: 0x475569), Color(hex: 0x111827)])
    static let arctic = NEXUSTheme(id: "arctic", name: "Arctic", subtitle: "Ледяная свежесть", colors: [Color(hex: 0x38BDF8), Color(hex: 0x2563EB)])
    static let sakura = NEXUSTheme(id: "sakura", name: "Sakura", subtitle: "Розовый закат", colors: [Color(hex: 0xF472B6), Color(hex: 0xA855F7)])
    static let emerald = NEXUSTheme(id: "emerald", name: "Emerald", subtitle: "Изумрудный тон", colors: [Color(hex: 0x34D399), Color(hex: 0x047857)])
    static let solarFlare = NEXUSTheme(id: "solar", name: "Solar Flare", subtitle: "Тёплое свечение", colors: [Color(hex: 0xF97316), Color(hex: 0xEAB308)])

    var gradient: LinearGradient {
        LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }
}
