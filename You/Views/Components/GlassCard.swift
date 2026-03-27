import SwiftUI

struct GlassCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 20
    var borderColor: Color = YouTheme.glassBorder

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(YouTheme.glassBackground)
                    )
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
