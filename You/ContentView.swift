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

    private var profile: UserProfile? { profiles.first }

    var body: some View {
        if profile?.onboardingCompleted == true {
            MainTabView()
        } else {
            OnboardingPlaceholderView(existingProfile: profile)
        }
    }
}

/// Temporary onboarding entry point — replaced by full OnboardingFlowView in Phase 8
struct OnboardingPlaceholderView: View {
    let existingProfile: UserProfile?
    @Environment(\.modelContext) var modelContext
    @State private var selectedGoals: Set<Goal> = []

    var body: some View {
        GoalSelectionView(selectedGoals: $selectedGoals) {
            let profile: UserProfile
            if let existing = existingProfile {
                profile = existing
            } else {
                profile = UserProfile()
                modelContext.insert(profile)
            }
            profile.selectedGoals = selectedGoals.map(\.rawValue)
            profile.onboardingCompleted = true
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: AppTab = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            YouTheme.background.ignoresSafeArea()

            ZStack {
                NavigationStack {
                    HomeView()
                        .navigationTitle("Good morning")
                        .navigationBarTitleDisplayMode(.large)
                }
                .opacity(selectedTab == .home ? 1 : 0)
                .allowsHitTesting(selectedTab == .home)

                NavigationStack {
                    CheckInPlaceholderView()
                        .navigationTitle("Check In")
                }
                .opacity(selectedTab == .checkIn ? 1 : 0)
                .allowsHitTesting(selectedTab == .checkIn)

                NavigationStack {
                    InsightsPlaceholderView()
                        .navigationTitle("Insights")
                }
                .opacity(selectedTab == .insights ? 1 : 0)
                .allowsHitTesting(selectedTab == .insights)
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
    }
}
