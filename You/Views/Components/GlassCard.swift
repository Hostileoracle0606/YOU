import SwiftUI

struct GlassCardModifier: ViewModifier {
    let cornerRadius: CGFloat
    let borderColor: Color

    init(cornerRadius: CGFloat = 20, borderColor: Color = YouTheme.glassBorder) {
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
    }

    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.ultraThinMaterial)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(YouTheme.glassBackground)
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 1)
            )
    }
}

extension View {
    func glassCard(cornerRadius: CGFloat = 20, borderColor: Color = YouTheme.glassBorder) -> some View {
        modifier(GlassCardModifier(cornerRadius: cornerRadius, borderColor: borderColor))
    }
}
