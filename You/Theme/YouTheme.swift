import SwiftUI

enum YouTheme {
    // MARK: - Colors
    static let background = Color(hex: 0x0A0A0F)
    static let surface = Color(hex: 0x131318)
    static let surfaceContainer = Color(hex: 0x1F1F25)
    static let surfaceContainerHigh = Color(hex: 0x2A292F)
    static let surfaceContainerHighest = Color(hex: 0x35343A)

    static let primary = Color(hex: 0xD2BBFF)
    static let primaryContainer = Color(hex: 0x7C3AED)
    static let primaryContainerDark = Color(hex: 0x523787)
    static let onPrimary = Color(hex: 0x3F008E)

    static let secondary = Color(hex: 0x4EDEA3)
    static let secondaryContainer = Color(hex: 0x00A572)

    static let tertiary = Color(hex: 0xF7BE1D)
    static let tertiaryWarm = Color(hex: 0xFFB95F)
    static let clusterAccent = Color(hex: 0xF59E0B)

    static let onSurface = Color(hex: 0xE4E1E9)
    static let onSurfaceVariant = Color(hex: 0xCCC3D8)
    static let outline = Color(hex: 0x958DA1)
    static let outlineVariant = Color(hex: 0x4A4455)

    static let error = Color(hex: 0xFFB4AB)

    // MARK: - Glass morphism
    static let glassBackground = Color.white.opacity(0.04)
    static let glassBorder = Color.white.opacity(0.05)

    // MARK: - Fonts
    static func headline(_ size: CGFloat) -> Font {
        .custom("Manrope-Bold", size: size)
    }
    static func bodyFont(_ size: CGFloat) -> Font {
        .custom("Inter-Regular", size: size)
    }
    static func label(_ size: CGFloat) -> Font {
        .custom("Inter-SemiBold", size: size)
    }
}

extension Color {
    init(hex: UInt, opacity: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}
