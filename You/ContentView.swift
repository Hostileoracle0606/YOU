//
//  ContentView.swift
//  You
//
//  Created by Trinab Goswamy on 2026-03-27.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedGoals: Set<Goal> = []

    var body: some View {
        GoalSelectionView(
            selectedGoals: $selectedGoals,
            onContinue: {}
        )
    }
}

#Preview {
    ContentView()
}
