import Foundation
import SwiftData

@Model
final class HabitLog {
    var logId: String
    var habitId: String
    var userId: String
    var completedAt: Date
    var qualityScore: Double
    var durationMins: Int
    var synced: Bool

    init(habitId: String, userId: String, qualityScore: Double = 1.0, durationMins: Int = 0) {
        self.logId = UUID().uuidString
        self.habitId = habitId
        self.userId = userId
        self.completedAt = Date()
        self.qualityScore = qualityScore
        self.durationMins = durationMins
        self.synced = false
    }
}
