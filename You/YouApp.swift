//
//  YouApp.swift
//  You
//
//  Created by Trinab Goswamy on 2026-03-27.
//

import SwiftUI
import SwiftData

@main
struct YouApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            UserProfile.self,
            Habit.self,
            HabitLog.self,
        ])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            // TODO: Replace with graceful error recovery before TestFlight
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    await seedHabitsIfNeeded()
                }
        }
        .modelContainer(sharedModelContainer)
    }

    @MainActor
    private func seedHabitsIfNeeded() async {
        let context = sharedModelContainer.mainContext
        let fetchDescriptor = FetchDescriptor<Habit>()
        let count = (try? context.fetchCount(fetchDescriptor)) ?? 0
        guard count == 0 else { return }

        let placeholderUserId = "seed-user"
        let seedHabits: [(name: String, category: String, sfSymbol: String, goalType: String, streak: Int, rate: Double)] = [
            ("Morning Meditation", "mindfulness", "figure.mind.and.body", "focusCognition", 7, 0.85),
            ("Cold Shower", "recovery", "drop.fill", "energy", 3, 0.72),
            ("10k Steps", "movement", "figure.walk", "strength", 12, 0.60),
            ("No screens 1hr before bed", "sleep", "moon.fill", "sleepQuality", 1, 0.90),
            ("Journaling", "reflection", "book", "stress", 5, 0.68),
        ]

        for seed in seedHabits {
            let habit = Habit(
                name: seed.name,
                category: seed.category,
                userId: placeholderUserId,
                goalType: seed.goalType,
                sfSymbol: seed.sfSymbol,
                currentStreak: seed.streak,
                completionRate: seed.rate
            )
            context.insert(habit)
        }

        try? context.save()
    }
}
