import SwiftUI

enum InsightType {
    case causal      // Gold border
    case correlated  // Violet border
    case cluster     // Orange border

    var borderColor: Color {
        switch self {
        case .causal: return YouTheme.tertiary
        case .correlated: return YouTheme.primaryContainer
        case .cluster: return Color(hex: 0xF59E0B)
        }
    }

    var label: String {
        switch self {
        case .causal: return "CAUSAL INSIGHT"
        case .correlated: return "CORRELATED"
        case .cluster: return "CLUSTER EFFECT"
        }
    }

    var labelColor: Color {
        switch self {
        case .causal: return YouTheme.tertiary
        case .correlated: return YouTheme.primaryContainer
        case .cluster: return Color(hex: 0xF59E0B)
        }
    }
}

struct InsightCard: View {
    let type: InsightType
    let headline: String
    let highlightText: String
    let confidence: String
    let observations: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Label row
            HStack(spacing: 8) {
                Circle()
                    .fill(type.labelColor)
                    .frame(width: 6, height: 6)
                Text(type.label)
                    .font(YouTheme.label(10))
                    .tracking(1.5)
                    .foregroundColor(type.labelColor)
            }

            // Headline
            Text(headline)
                .font(YouTheme.headline(16))
                .foregroundColor(YouTheme.onSurface)

            // Highlight
            Text(highlightText)
                .font(.system(size: 24, weight: .black))
                .foregroundColor(.white)

            // Footer
            HStack {
                Label(confidence, systemImage: "chart.bar")
                    .font(YouTheme.label(11))
                    .foregroundColor(YouTheme.onSurfaceVariant)
                Spacer()
                Text("\(observations) observations")
                    .font(YouTheme.label(11))
                    .foregroundColor(YouTheme.onSurfaceVariant)
            }
        }
        .padding(20)
        .glassCard(cornerRadius: 20, borderColor: type.borderColor)
    }
}
