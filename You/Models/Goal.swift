import SwiftUI

enum Goal: String, CaseIterable, Identifiable, Codable {
    case focusCognition = "Focus & Cognition"
    case sleepQuality = "Sleep Quality"
    case energy = "Energy"
    case mood = "Mood"
    case weight = "Weight"
    case strength = "Strength"
    case hrv = "HRV"
    case productivity = "Productivity"
    case stress = "Stress"
    case skinHealth = "Skin Health"
    case digestion = "Digestion"
    case longevity = "Longevity"

    var id: String { rawValue }

    var sfSymbol: String {
        switch self {
        case .focusCognition: return "brain.head.profile"
        case .sleepQuality: return "moon.fill"
        case .energy: return "bolt.fill"
        case .mood: return "face.smiling"
        case .weight: return "scalemass"
        case .strength: return "dumbbell"
        case .hrv: return "heart.fill"
        case .productivity: return "chart.line.uptrend.xyaxis"
        case .stress: return "figure.mind.and.body"
        case .skinHealth: return "face.smiling.inverse"
        case .digestion: return "leaf"
        case .longevity: return "hourglass"
        }
    }
}
