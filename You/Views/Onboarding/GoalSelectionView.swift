import SwiftUI

struct GoalSelectionView: View {
    @Binding var selectedGoals: Set<Goal>
    var onBack: (() -> Void)?
    var onContinue: () -> Void

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ZStack {
            YouTheme.background.ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { onBack?() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(YouTheme.primary)
                    }
                    .opacity(onBack == nil ? 0 : 1)  // Hidden on screen 1 where there's no previous screen
                    Spacer()
                    Text("1 of 4")
                        .font(YouTheme.label(11))
                        .tracking(0.5)
                        .textCase(.uppercase)
                        .foregroundColor(YouTheme.onSurfaceVariant)
                    Spacer()
                    Color.clear.frame(width: 32)
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        // Hero
                        VStack(alignment: .leading, spacing: 12) {
                            Text("What's your primary goal?")
                                .font(YouTheme.headline(28))
                                .tracking(-1.2)
                                .foregroundColor(.white)

                            Text("We'll build your causal graph around it")
                                .font(YouTheme.bodyFont(14))
                                .foregroundColor(YouTheme.onSurfaceVariant)
                        }
                        .padding(.top, 24)
                        .padding(.bottom, 40)

                        // Goal Grid
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(Goal.allCases) { goal in
                                GoalCard(
                                    goal: goal,
                                    isSelected: selectedGoals.contains(goal),
                                    onTap: {
                                        if selectedGoals.contains(goal) {
                                            selectedGoals.remove(goal)
                                        } else {
                                            selectedGoals.insert(goal)
                                        }
                                    }
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 160)
                }
            }

            // Bottom CTA
            VStack {
                Spacer()
                Button(action: onContinue) {
                    HStack {
                        Text("Continue")
                            .fontWeight(.bold)
                        Image(systemName: "arrow.right")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        LinearGradient(
                            colors: [YouTheme.primaryContainer, YouTheme.primaryContainerDark],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
                .background(
                    LinearGradient(
                        colors: [YouTheme.surface.opacity(0), YouTheme.surface.opacity(0.9), YouTheme.surface],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }

            // Decorative glow
            Circle()
                .fill(YouTheme.primaryContainer.opacity(0.1))
                .blur(radius: 120)
                .frame(width: 320, height: 320)
                .offset(x: 100, y: 300)
                .allowsHitTesting(false)
        }
    }
}

struct GoalCard: View {
    let goal: Goal
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 16) {
                ZStack {
                    Circle()
                        .fill(isSelected ? YouTheme.primaryContainer : YouTheme.surfaceContainerHighest)
                        .frame(width: 40, height: 40)
                    Image(systemName: goal.sfSymbol)
                        .font(.system(size: 18))
                        .foregroundColor(isSelected ? .white : YouTheme.onSurfaceVariant)
                }

                Text(goal.rawValue)
                    .font(YouTheme.label(14))
                    .tracking(-0.3)
                    .foregroundColor(isSelected ? .white : YouTheme.onSurfaceVariant)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .glassCard(
                cornerRadius: 16,
                borderColor: isSelected ? YouTheme.primary.opacity(0.3) : Color.white.opacity(0.05)
            )
            .shadow(color: isSelected ? YouTheme.primaryContainer.opacity(0.25) : .clear, radius: 20)
        }
        .buttonStyle(.plain)
    }
}
