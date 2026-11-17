import SwiftUI

struct ContactsView: View {
    @EnvironmentObject private var appState: AppState
    var body: some View {
        VStack(spacing: 18) {
            ScreenHeader(title: "Контакты")
            GlassCard {
                HStack {
                    Image(systemName: "person.crop.circle.badge.plus").font(.title2)
                    VStack(alignment: .leading) {
                        Text("Пригласить друзей").font(.headline)
                        Text("Найдите знакомых в NEXUS").font(.caption).foregroundStyle(.white.opacity(0.5))
                    }
                    Spacer()
                    Image(systemName: "chevron.right").foregroundStyle(.white.opacity(0.4))
                }.foregroundStyle(.white)
            }
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(appState.contacts) { contact in
                        HStack(spacing: 12) {
                            AvatarView(initials: contact.initials, colors: appState.selectedTheme.colors, size: 46)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(contact.name).foregroundStyle(.white).font(.system(size: 15, weight: .semibold))
                                Text(contact.status).foregroundStyle(.white.opacity(0.42)).font(.caption)
                            }
                            Spacer()
                            Image(systemName: "message").foregroundStyle(.white.opacity(0.55))
                        }.padding(10)
                    }
                }
            }
            Spacer()
        }.padding(.horizontal, 20).padding(.top, 14)
    }
}
