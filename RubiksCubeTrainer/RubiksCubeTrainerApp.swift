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
    @StateObject private var solveCountModel: SolveCountModel
    @StateObject var phoneConnectivity: PhoneConnectivity
    
    init() {
        let model = SolveCountModel()
        _solveCountModel = StateObject(wrappedValue: model)
        _phoneConnectivity = StateObject(wrappedValue: PhoneConnectivity(solveCountModel: model))
        // Allow background audio (e.g., music) to continue playing
            // Allow background audio (e.g., music) to continue playing
        try? AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: [.mixWithOthers])
            try? AVAudioSession.sharedInstance().setActive(true)
        }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [SolveTime.self, CFOPSolveTime.self])
                .environmentObject(solveCountModel)
                .environmentObject(phoneConnectivity)
        }
    }
}
