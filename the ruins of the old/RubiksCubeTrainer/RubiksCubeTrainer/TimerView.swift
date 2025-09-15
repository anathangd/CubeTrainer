//
//  TimerView.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 2025-03-27.
//

import SwiftUI
import SwiftData
import Charts
import ConfettiSwiftUI

struct TimerView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SolveTime.date, order: .reverse) var solves: [SolveTime]
    
    @State private var inspectionTime = 15
    @State private var solveTime: TimeInterval = 0
    @State private var currentSolveTime: Double? = nil
    
    @State private var isInspecting = false
    @State private var isSolving = false
    @State private var thumbLeft = false
    @State private var thumbRight = false
    @State private var thumbPressed = ThumbState()
    @State private var timer: Timer?
    @State private var startTime: Date?
    @State private var savedTimes: [(time: TimeInterval, memo: String)] = []
    @State private var memo = ""
    @State var finished = false
    @State var readyToSolve = false
    @State var listView = false
    @State var saved = false
    
    var personalBest: Double {
        solves.map { $0.solveTime }.min() ?? Double.greatestFiniteMagnitude
    }
    var isNewPB: Bool {
        (currentSolveTime ?? Double.greatestFiniteMagnitude) < personalBest
    }
    @State var isNewPBAttached = false
    @State private var confettiCounter = 0
    
    var formattedTime: String {
        let totalMilliseconds = Int(solveTime * 100)
        let minutes = totalMilliseconds / 6000
        let seconds = (totalMilliseconds / 100) % 60
        let milliseconds = totalMilliseconds % 100
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.yellow)
                .onTapGesture {
                    if isSolving {
                        finished = true
                        stopSolve()
                        currentSolveTime = solveTime
                    }
                }
            
//            VStack {
//                Text("\(thumbLeft), \(thumbRight)")
//                Spacer()
//            } // thumb pressed indicators
            
            VStack {
                if isInspecting {
                    HStack {
                        Button(action: {}) {
                            Text("Hold here")
                                .foregroundStyle(.blue)
                                .frame(width: 150, height: 100)
                                .background(thumbLeft ? Color.black.opacity(0.9) : Color.gray.opacity(0.5))
                                .cornerRadius(10)
                        }
                        .buttonStyle(.plain)
                        .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    thumbLeft = true
                                    checkThumbs()
                                }
                                .onEnded { _ in
                                    thumbLeft = false
                                    checkThumbs()
                                }
                        )

                        Button(action: {}) {
                            Text("Hold here")
                                .foregroundStyle(.blue)
                                .frame(width: 150, height: 100)
                                .background(thumbRight ? Color.black.opacity(0.9) : Color.gray.opacity(0.5))
                                .cornerRadius(10)
                        }
                        .buttonStyle(.plain)
                        .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    thumbRight = true
                                    checkThumbs()
                                }
                                .onEnded { _ in
                                    thumbRight = false
                                    checkThumbs()
                                }
                        )
                    }
                }
            } // thumb buttons
            .padding(.top, 250)
            
            VStack(spacing: 20) {
                if readyToSolve {
                    Text("Ready")
                        .font(.largeTitle)
                }
                if isInspecting && !readyToSolve {
                    Text("Inspection Time")
                        .font(.largeTitle)
                    Text(String(inspectionTime))
                        .font(.largeTitle)
                        .monospacedDigit()
                }
                
                if isSolving || finished {
                    if isNewPB || isNewPBAttached {
                        Text("New personal best! 🎉")
                            .font(.title2)
                            .onAppear {
                                confettiCounter += 1
                                isNewPBAttached = true
                            }
                    }
                    Text(formattedTime)
                        .font(.system(size: 80))
                        .monospacedDigit()
                        .padding()
                        .onTapGesture {
                            if isSolving {
                                finished = true
                                stopSolve()
                                currentSolveTime = solveTime
                            }
                        }
                }
                
                if !isInspecting && !isSolving {
                    Button(action: {
                        startInspection()
                        saved = false
                        isNewPBAttached = false
                        currentSolveTime = nil
                    }) {
                        Text("Start Inspection")
                            .padding(20)
                    }
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    .padding(10)
                    
                    if !finished {
                        Button(action: {
                            listView = true
                        }) {
                            Text("Past Solves")
                                .padding(20)
                        }
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                    }
                }
                
                if finished {
                    VStack {
                        TextField("Memo", text: $memo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(saved)
                            .padding()
                        
                        Button(action: {
                            saveTime()
                            saved = true
                        }) {
                            Text("Save Time")
                                .padding(20)
                        }
                        .background(saved ? .gray : .blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        .disabled(saved)
                        
                        Button(action: {
                            listView = true
                        }) {
                            Text("Past Solves")
                                .padding(20)
                        }
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                    }
                }
            }
            .onTapGesture {
                if isSolving {
                    finished = true
                    stopSolve()
                }
            }
            .padding()
            
            if listView {
                VStack(spacing: 0) {
                    if let personalBest = solves.map({ $0.solveTime }).min() {
                        HStack {
                            Text("Personal Best:")
                                .font(.title2)
                                .bold()
                            Text("\(personalBest, specifier: "%.2f")")
                                .font(.title)
                                .bold()
                        }
                    }
                    // Average of last 5 solves
                    if solves.count >= 1 {
                        let recentSolves = solves.prefix(5)
                        let average = recentSolves.map { $0.solveTime }.reduce(0, +) / Double(recentSolves.count)
                        HStack {
                            Text("Average of Last \(recentSolves.count): ")
                                .font(.title2)
                                .bold()
                                // .padding()
                            Text("\(average, specifier: "%.2f")")
                                .font(.title)
                                .bold()
                                // .padding()
                        }
                    }
                    
                    let times = solves.map { $0.solveTime }
                    let minY = max((times.min() ?? 0) - 1, 0) // Avoid negative values
                    let maxY = (times.max() ?? 0) + 1
                    Chart {
                        // Solve times
                        ForEach(Array(solves.reversed().enumerated()), id: \.offset) { index, solve in
                                LineMark(
                                    x: .value("Solve #", index + 1),
                                    y: .value("Time", solve.solveTime)
                                )
                            .foregroundStyle(.blue)
                            .interpolationMethod(.linear)
                            .symbol(Circle())
                        }
                    }
                    .chartYScale(domain: minY...maxY)
                    .chartXScale(domain: 0...solves.count + 1)
                    .frame(height: 200)
                    .padding(.horizontal)
                    
                    Text("Total Solves: \(solves.count)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding()
                    
                    List {
                        ForEach(solves) { solve in
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Time: ")
                                    Text("\(solve.solveTime, specifier: "%.2f")")
                                        .font(.title)
                                        .bold()
                                }
                                if solve.memo != "" {
                                    Text("Memo: \(solve.memo)")
                                }
                                Text("Date: \(solve.date.formatted())")
                            }
                            .padding(.top, 0)
                        }
                        .onDelete(perform: deleteSolves)
                        .padding(.top, -10)
                    }
                    .listStyle(.insetGrouped)
                    .padding(.top, -30)
                    Button("done") {
                        listView = false
                    }
                    .padding()
                }
                .scrollContentBackground(.hidden)
                .background(Color.yellow)
            } //solves
        }
        .confettiCannon(trigger: $confettiCounter, confettiSize: 14, radius: 450, repetitions: 4, repetitionInterval: 0.3)
    }
    
    func startInspection() {
        finished = false
        isInspecting = true
        inspectionTime = 15
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if inspectionTime > 0 {
                inspectionTime -= 1
            } else {
                timer?.invalidate()
                // isInspecting = false
            }
        }
    }
    
    func checkThumbs() {
        if thumbLeft && thumbRight {
            readyToSolve = true
        }
        if readyToSolve && !thumbLeft && !thumbRight {
            startSolve()
        }
    }
    
    func startSolve() {
        readyToSolve = false
        isSolving = true
        isInspecting = false
        thumbPressed = ThumbState()
        startTime = Date()
        solveTime = 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { t in
            if let start = startTime {
                let elapsed = Date().timeIntervalSince(start)
                DispatchQueue.main.async {
                    solveTime = elapsed
                }
            }
        }
    }
    
    func stopSolve() {
        timer?.invalidate()
        timer = nil
        if let start = startTime {
            solveTime = Date().timeIntervalSince(start)
        }
        isSolving = false
    }
    
    func saveTime() {
        let solve = SolveTime(solveTime: solveTime, memo: memo)
        modelContext.insert(solve)
        memo = ""
        print("Solves count: \(solves.count)")
    }
    
    func deleteSolves(at offsets: IndexSet) {
        for index in offsets {
            let solve = solves[index]
            modelContext.delete(solve)
        }
        print("Solves count: \(solves.count)")
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context after deletion: \(error)")
        }
    }
}

struct ThumbState {
    var left: Bool = false
    var right: Bool = false
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    TimerView()
}
