//
//  RubiksCubeTrainerApp.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 2025-03-20.
//

import SwiftUI
import SwiftData
import AVFoundation

@main
struct RubiksCubeTrainerApp: App {
    init() {
            // Allow background audio (e.g., music) to continue playing
        try? AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: [.mixWithOthers])
            try? AVAudioSession.sharedInstance().setActive(true)
        }
    @StateObject private var solveCountModel = SolveCountModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [SolveTime.self, CFOPSolveTime.self])
                .environmentObject(solveCountModel)
        }
    }
}
