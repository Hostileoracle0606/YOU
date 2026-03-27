import Foundation
import SwiftData

@Model
final class Habit {
    var habitId: String
    var name: String
    var category: String
    var userId: String
    var goalType: String
    var sfSymbol: String
    var isActive: Bool
    var createdAt: Date

    // Computed locally, synced from Neo4j
    var currentStreak: Int
    var completionRate: Double
    var causalInfluenceScore: Double

    init(
        name: String,
        category: String = "",
        userId: String,
        goalType: String = "",
        sfSymbol: String = "circle",
        currentStreak: Int = 0,
        completionRate: Double = 0,
        causalInfluenceScore: Double = 0
    ) {
        self.habitId = UUID().uuidString
        self.name = name
        self.category = category
        self.userId = userId
        self.goalType = goalType
        self.sfSymbol = sfSymbol
        self.isActive = true
        self.createdAt = Date()
        self.currentStreak = currentStreak
        self.completionRate = completionRate
        self.causalInfluenceScore = causalInfluenceScore
    }
}
