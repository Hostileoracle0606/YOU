import SwiftUI
import SwiftData

struct HomeView: View {
    @Query(filter: #Predicate<Habit> { $0.isActive }) var habits: [Habit]
    @Query var profiles: [UserProfile]

    @State private var todayLogs: Set<String> = []  // habitIds completed today

    private var userId: String { profiles.first?.userId ?? "" }

    private var ringData: [(name: String, progress: Double, color: Color, symbol: String)] {
        let ringColors: [Color] = [YouTheme.primary, YouTheme.secondary, YouTheme.tertiary]
        return habits.prefix(3).enumerated().map { index, habit in
            (
                name: habit.name,
                progress: todayLogs.contains(habit.habitId) ? 1.0 : habit.completionRate,
                color: ringColors[index % ringColors.count],
                symbol: habit.sfSymbol
            )
        }
    }

    var body: some View {
        ZStack {
            YouTheme.background.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    // Habit rings
                    HabitRingsView(habits: ringData)
                        .padding(.top, 16)

                    // Top causal insight card (static placeholder until Phase 4)
                    InsightCard(
                        type: .causal,
                        headline: "Morning meditation → Focus score",
                        highlightText: "improves by 34%",
                        confidence: "[28%–41%]",
                        observations: 47
                    )
                    .padding(.horizontal, 24)

                    // Habit checklist
                    VStack(alignment: .leading, spacing: 12) {
                        Text("TODAY")
                            .font(YouTheme.label(11))
                            .tracking(2)
                            .foregroundColor(YouTheme.onSurfaceVariant)
                            .padding(.horizontal, 24)

                        ForEach(habits) { habit in
                            HabitRow(
                                habit: habit,
                                isCompleted: todayLogs.contains(habit.habitId),
                                onToggle: { toggleHabit(habit) }
                            )
                            .padding(.horizontal, 24)
                        }
                    }
                }
                .padding(.bottom, 120)
            }
        }
        .navigationTitle("Good morning")
        .navigationBarTitleDisplayMode(.large)
    }

    private func toggleHabit(_ habit: Habit) {
        if todayLogs.contains(habit.habitId) {
            todayLogs.remove(habit.habitId)
        } else {
            todayLogs.insert(habit.habitId)
        }
    }
}

struct HabitRow: View {
    let habit: Habit
    let isCompleted: Bool
    let onToggle: () -> Void

    var body: some View {
        Button(action: onToggle) {
            HStack(spacing: 16) {
                // Completion circle
                ZStack {
                    Circle()
                        .stroke(isCompleted ? YouTheme.secondary : YouTheme.outlineVariant, lineWidth: 2)
                        .frame(width: 28, height: 28)
                    if isCompleted {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(YouTheme.secondary)
                    }
                }

                // Icon + name
                Image(systemName: habit.sfSymbol)
                    .font(.system(size: 16))
                    .foregroundColor(isCompleted ? YouTheme.secondary : YouTheme.primary)
                    .frame(width: 24)

                Text(habit.name)
                    .font(YouTheme.label(15))
                    .foregroundColor(isCompleted ? YouTheme.onSurfaceVariant : YouTheme.onSurface)
                    .strikethrough(isCompleted, color: YouTheme.onSurfaceVariant)

                Spacer()

                // Streak badge
                if habit.currentStreak > 0 {
                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 11))
                            .foregroundColor(YouTheme.tertiaryWarm)
                        Text("\(habit.currentStreak)")
                            .font(YouTheme.label(11))
                            .foregroundColor(YouTheme.tertiaryWarm)
                    }
                }
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .glassCard(cornerRadius: 14)
        }
        .buttonStyle(.plain)
    }
}
