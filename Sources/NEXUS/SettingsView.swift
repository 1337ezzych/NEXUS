import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var appState: AppState
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ScreenHeader(title: "Настройки")
                GlassCard {
                    HStack(spacing: 14) {
                        AvatarView(initials: "NX", colors: appState.selectedTheme.colors, size: 62)
                        VStack(alignment: .leading, spacing: 5) {
                            Text("NEXUS Profile").font(.headline).foregroundStyle(.white)
                            Text("Локальный демонстрационный профиль").font(.caption).foregroundStyle(.white.opacity(0.45))
                        }
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }
                Text("ВНЕШНИЙ ВИД").font(.system(size: 11, weight: .bold)).tracking(2).foregroundStyle(.white.opacity(0.42))
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(NEXUSTheme.all) { theme in
                        Button { withAnimation(.easeInOut) { appState.selectedTheme = theme } } label: {
                            VStack(alignment: .leading, spacing: 10) {
                                RoundedRectangle(cornerRadius: 13).fill(theme.gradient).frame(height: 55)
                                    .overlay(alignment: .topTrailing) {
                                        if appState.selectedTheme.id == theme.id {
                                            Image(systemName: "checkmark.circle.fill").foregroundStyle(.white).padding(8)
                                        }
                                    }
                                Text(theme.name).font(.system(size: 14, weight: .semibold)).foregroundStyle(.white)
                                Text(theme.subtitle).font(.system(size: 11)).foregroundStyle(.white.opacity(0.45))
                            }.padding(12).background(.white.opacity(0.055), in: RoundedRectangle(cornerRadius: 18))
                        }.buttonStyle(.plain)
                    }
                }
                Text("ПОДКЛЮЧЕНИЕ").font(.system(size: 11, weight: .bold)).tracking(2).foregroundStyle(.white.opacity(0.42))
                GlassCard {
                    Label("Telegram / TDLib: не подключено", systemImage: "link").foregroundStyle(.white)
                    Text("Сейчас приложение работает в демо-режиме. Инструкция находится в Documentation/TDLIB_SETUP.md.")
                        .font(.caption).foregroundStyle(.white.opacity(0.5)).padding(.top, 6)
                }
            }.padding(20)
        }
    }
}
