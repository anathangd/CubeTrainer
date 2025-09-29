//
//  ContentView.swift
//  RubiksCubeTrainerWatch Watch App
//
//  Created by Nathan Davis on 9/29/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var watchManager = WatchConnectivityManager.shared
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(watchManager.solveCount)")
                .font(.system(size: 50))
            
            Button("+") {
                watchManager.incrementSolve()
            }
            .font(.title)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .padding()
        .onAppear {
            print("requesting solve count")
            watchManager.requestCurrentSolveCount()
        }
    }
}

#Preview {
    ContentView()
}
