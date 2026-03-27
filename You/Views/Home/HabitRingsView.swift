import SwiftUI

struct HabitRingsView: View {
    let habits: [(id: String, name: String, progress: Double, color: Color, symbol: String)]

    var overallProgress: Int {
        guard !habits.isEmpty else { return 0 }
        let avg = habits.map(\.progress).reduce(0, +) / Double(habits.count)
        return Int(avg * 100)
    }

    var body: some View {
        ZStack {
            // Background glow
            Circle()
                .fill(
                    RadialGradient(
                        colors: [YouTheme.primaryContainer.opacity(0.1), .clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 160
                    )
                )
                .frame(width: 320, height: 320)

            // Rings (up to 3)
            ForEach(Array(habits.prefix(3).enumerated()), id: \.element.id) { index, habit in
                let radius: CGFloat = CGFloat(144 - index * 40)
                ZStack {
                    Circle()
                        .stroke(YouTheme.surfaceContainerHigh, lineWidth: 12)
                        .frame(width: radius, height: radius)
                    Circle()
                        .trim(from: 0, to: habit.progress)
                        .stroke(
                            habit.color,
                            style: StrokeStyle(lineWidth: 12, lineCap: .round)
                        )
                        .frame(width: radius, height: radius)
                        .rotationEffect(.degrees(-90))
                        .shadow(color: habit.color.opacity(0.3), radius: 8)
                }
            }

            // Center text
            VStack(spacing: 4) {
                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Text("\(overallProgress)")
                        .font(.system(size: 48, weight: .black))
                        .foregroundColor(YouTheme.onSurface)
                    Text("%")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(YouTheme.onSurface.opacity(0.5))
                }
                Text("DAILY FLOW")
                    .font(YouTheme.label(10))
                    .tracking(2)
                    .foregroundColor(YouTheme.onSurfaceVariant)
            }
        }
        .frame(height: 288)
    }
}
