//
//  ContentView.swift
//  You
//
//  Created by Trinab Goswamy on 2026-03-27.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var profiles: [UserProfile]

    private var hasCompletedOnboarding: Bool {
        profiles.first?.onboardingCompleted ?? false
    }

    var body: some View {
        if hasCompletedOnboarding {
            MainTabView()
        } else {
            OnboardingPlaceholderView()
        }
    }
}

/// Temporary onboarding entry point — replaced by full OnboardingFlowView in Phase 8
struct OnboardingPlaceholderView: View {
    @Environment(\.modelContext) var modelContext
    @Query var profiles: [UserProfile]

    var body: some View {
        GoalSelectionView(selectedGoals: .constant([])) {
            // Mark onboarding complete so we route to MainTabView
            let profile: UserProfile
            if let existing = profiles.first {
                profile = existing
            } else {
                let p = UserProfile()
                modelContext.insert(p)
                profile = p
            }
            profile.onboardingCompleted = true
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: AppTab = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            YouTheme.background.ignoresSafeArea()

            Group {
                switch selectedTab {
                case .home:
                    NavigationStack {
                        HomeView()
                    }
                case .checkIn:
                    NavigationStack {
                        CheckInPlaceholderView()
                    }
                case .insights:
                    NavigationStack {
                        InsightsPlaceholderView()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

/// Placeholder — replaced by DailyCheckInView in Phase 2
struct CheckInPlaceholderView: View {
    var body: some View {
        ZStack {
            YouTheme.background.ignoresSafeArea()
            VStack(spacing: 16) {
                Image(systemName: "mic.fill")
                    .font(.system(size: 48))
                    .foregroundColor(YouTheme.primary)
                Text("Daily Check-in")
                    .font(YouTheme.headline(20))
                    .foregroundColor(.white)
                Text("Coming in Phase 2")
                    .font(YouTheme.bodyFont(14))
                    .foregroundColor(YouTheme.onSurfaceVariant)
            }
        }
        .navigationTitle("Check In")
    }
}

/// Placeholder — replaced by InsightsView in Phase 4
struct InsightsPlaceholderView: View {
    var body: some View {
        ZStack {
            YouTheme.background.ignoresSafeArea()
            VStack(spacing: 16) {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.system(size: 48))
                    .foregroundColor(YouTheme.tertiary)
                Text("Your Insights")
                    .font(YouTheme.headline(20))
                    .foregroundColor(.white)
                Text("Coming in Phase 4")
                    .font(YouTheme.bodyFont(14))
                    .foregroundColor(YouTheme.onSurfaceVariant)
            }
        }
        .navigationTitle("Insights")
    }
}
