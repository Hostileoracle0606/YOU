import SwiftUI

enum AppTab: String, CaseIterable {
    case home = "Home"
    case checkIn = "Check In"
    case insights = "Insights"

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .checkIn: return "mic.fill"
        case .insights: return "chart.line.uptrend.xyaxis"
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases, id: \.self) { tab in
                Button(action: { selectedTab = tab }) {
                    VStack(spacing: 6) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 22))
                            .foregroundColor(selectedTab == tab ? YouTheme.primary : YouTheme.onSurfaceVariant)
                        Text(tab.rawValue)
                            .font(YouTheme.label(10))
                            .foregroundColor(selectedTab == tab ? YouTheme.primary : YouTheme.onSurfaceVariant)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                }
                .buttonStyle(.plain)
            }
        }
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.ultraThinMaterial)
                RoundedRectangle(cornerRadius: 24)
                    .fill(YouTheme.glassBackground)
            }
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(YouTheme.glassBorder, lineWidth: 1)
        )
        .padding(.horizontal, 24)
        .padding(.bottom, 8)
    }
}
