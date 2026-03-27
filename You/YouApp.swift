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
        // TODO: Replace fatalError with graceful error recovery before TestFlight
        return try! ModelContainer(for: schema, configurations: [config])
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
        let seedHabits: [(String, String, String)] = [
            ("Morning Meditation", "mindfulness", "figure.mind.and.body"),
            ("Cold Shower", "recovery", "drop.fill"),
            ("10k Steps", "movement", "figure.walk"),
            ("No screens 1hr before bed", "sleep", "moon.fill"),
            ("Journaling", "reflection", "book"),
        ]

        for (name, category, symbol) in seedHabits {
            let habit = Habit(
                name: name,
                category: category,
                userId: placeholderUserId,
                goalType: "sleepQuality",
                sfSymbol: symbol,
                currentStreak: Int.random(in: 0...14),
                completionRate: Double.random(in: 0.4...0.9)
            )
            context.insert(habit)
        }

        try? context.save()
    }
}
