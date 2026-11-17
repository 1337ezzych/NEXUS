import SwiftUI

struct AvatarView: View {
    let initials: String
    let colors: [Color]
    var size: CGFloat = 54

    var body: some View {
        ZStack {
            Circle().fill(LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
            Text(initials).font(.system(size: size * 0.38, weight: .bold, design: .rounded)).foregroundStyle(.white)
        }
        .frame(width: size, height: size)
        .overlay(Circle().stroke(.white.opacity(0.2), lineWidth: 1))
        .shadow(color: colors.first?.opacity(0.28) ?? .clear, radius: 12, y: 5)
    }
}

struct GlassCard<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        content.padding(16)
            .background(.white.opacity(0.055), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 22).stroke(.white.opacity(0.08), lineWidth: 1))
    }
}

struct ScreenHeader: View {
    let title: String
    var trailing: String? = nil
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("NEXUS").font(.system(size: 11, weight: .heavy, design: .rounded)).tracking(3).foregroundStyle(.white.opacity(0.42))
                Text(title).font(.system(size: 30, weight: .bold, design: .rounded)).foregroundStyle(.white)
            }
            Spacer()
            if let trailing {
                Text(trailing).font(.system(size: 12, weight: .semibold)).foregroundStyle(.white.opacity(0.6))
            }
        }
    }
}
