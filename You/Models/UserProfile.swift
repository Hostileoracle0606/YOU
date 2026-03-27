import Foundation
import SwiftData

@Model
final class UserProfile {
    var userId: String
    var selectedGoals: [String]  // Goal rawValues
    var onboardingCompleted: Bool
    var createdAt: Date

    init(userId: String = UUID().uuidString) {
        self.userId = userId
        self.selectedGoals = []
        self.onboardingCompleted = false
        self.createdAt = Date()
    }
}
