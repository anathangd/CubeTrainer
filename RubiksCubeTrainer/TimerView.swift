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
    @State private var scramble = ""
    @EnvironmentObject var solveCountModel: SolveCountModel
    @State var editCount = false
    let worldRecordTime = 3.08
    @State var worldRecord = false
    
    var scrambleLines: [[String]] {
        let moves = scramble.split(separator: " ").map { String($0) }
        var currentLine: [String] = []
        var lines: [[String]] = []

        for move in moves {
            currentLine.append(move)
            if currentLine.count == 10 { // moves per line
                lines.append(currentLine)
                currentLine = []
            }
        }
        if !currentLine.isEmpty { lines.append(currentLine) }
        return lines
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.yellow)
                .onTapGesture {
                    editCount = false
                    if isSolving {
                        finished = true
                        stopSolve()
                        currentSolveTime = solveTime
                    }
                }
            if !isInspecting && !isSolving {
                SolveCountButton(editCount: $editCount)
            }
            
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
                    if worldRecord {
                        Text("NEW WORLD RECORD!!")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.red)
                    }
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
                    ZStack {
                        if !finished {
                            VStack(alignment: .center, spacing: 4) {
                                ForEach(scrambleLines, id: \.self) { line in
                                    HStack(spacing: 8) {
                                        ForEach(line, id: \.self) { move in
                                            Text(move)
                                                .font(.title)
                                        }
                                    }
                                }
                            }
                            .multilineTextAlignment(.center)
                            .frame(height: 90)
                        }
                    }
                    CapsuleButton(title: "Generate Scramble", action: {
                        generateScramble()
                        finished = false
                    })
                    CapsuleButton(title: "Start Inspection", action: {
                        startInspection()
                        saved = false
                        isNewPBAttached = false
                        currentSolveTime = nil
                    })
                    
                    if !finished {
                        CapsuleButton(title: "Past Solves", action: {
                            listView = true
                        })
                    }
                }
                
                if finished {
                    VStack {
                        TextField("Memo", text: $memo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(saved)
                            .padding()
                        
                        CapsuleButton(title: "Save Time", color: saved ? .gray : .blue, action: {
                            saveTime()
                            saved = true
                        })
                        .disabled(saved)
                        
                        CapsuleButton(title: "Past Solves", action: {
                            listView = true
                        })
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
        worldRecord = false
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
        solveCountModel.count += 1
        if solveTime < worldRecordTime {
                worldRecord = true
                confettiCounter += 1
        }
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
    func generateScramble(length: Int = 20) {
        struct Move {
            let axis: String
            let turns: [String]
        }

        let moveOptions: [Move] = [
            Move(axis: "U", turns: ["U", "U'", "U2"]),
            Move(axis: "D", turns: ["D", "D'", "D2"]),
            Move(axis: "L", turns: ["L", "L'", "L2"]),
            Move(axis: "R", turns: ["R", "R'", "R2"]),
            Move(axis: "F", turns: ["F", "F'", "F2"]),
            Move(axis: "B", turns: ["B", "B'", "B2"]),
        ]

        var scrambleMoves: [String] = []
        var lastFace: String? = nil
        var lastAxis: String? = nil

        while scrambleMoves.count < length {
            let move = moveOptions.randomElement()!
            let face = move.axis
            let axisGroup = axis(for: face)

            // Skip if same face or same axis as previous move
            if face == lastFace || axisGroup == lastAxis {
                continue
            }

            let turn = move.turns.randomElement()!
            scrambleMoves.append(turn)

            lastFace = face
            lastAxis = axisGroup
        }

        scramble = scrambleMoves.joined(separator: " ")
    }

    // Determines the axis group of a face (U/D, L/R, F/B)
    func axis(for face: String) -> String {
        switch face {
        case "U", "D": return "UD"
        case "L", "R": return "LR"
        case "F", "B": return "FB"
        default: return ""
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

//#Preview {
//    TimerView()
//}
