//
//  CFOPStepTimerView.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 2025-06-14.
//

import SwiftUI
import SwiftData
import Charts
import ConfettiSwiftUI

struct CFOPStepTimerView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \CFOPSolveTime.date, order: .reverse) var solves: [CFOPSolveTime]
    
    @State private var inspectionTime = 15
    @State private var solveTime: TimeInterval = 0
    @State private var currentTotalSolveTime: Double? = nil
    @State private var currentCrossSolveTime: Double? = nil
    @State private var currentF2LSolveTime: Double? = nil
    @State private var currentOLLSolveTime: Double? = nil
    @State private var currentPLLSolveTime: Double? = nil
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
    
    var crossPersonalBest: Double {
        solves.map { $0.crossSolveTime }.min() ?? Double.greatestFiniteMagnitude
    }
    var isNewCrossPB: Bool {
        (currentCrossSolveTime ?? Double.greatestFiniteMagnitude) < crossPersonalBest
    }
    var f2LPersonalBest: Double {
        solves.map { $0.f2LSolveTime }.min() ?? Double.greatestFiniteMagnitude
    }
    var isNewF2LPB: Bool {
        (currentF2LSolveTime ?? Double.greatestFiniteMagnitude) < f2LPersonalBest
    }
    var ollPersonalBest: Double {
        solves.map { $0.ollSolveTime }.min() ?? Double.greatestFiniteMagnitude
    }
    var isNewOLLPB: Bool {
        (currentOLLSolveTime ?? Double.greatestFiniteMagnitude) < ollPersonalBest
    }
    var pllPersonalBest: Double {
        solves.map { $0.pllSolveTime }.min() ?? Double.greatestFiniteMagnitude
    }
    var isNewPLLPB: Bool {
        (currentPLLSolveTime ?? Double.greatestFiniteMagnitude) < pllPersonalBest
    }
    var totalPersonalBest: Double {
        solves.map {
            $0.crossSolveTime + $0.f2LSolveTime + $0.ollSolveTime + $0.pllSolveTime
        }.min() ?? Double.greatestFiniteMagnitude
    }
    var isNewTotalPB: Bool {
        guard let cross = currentCrossSolveTime,
              let f2l = currentF2LSolveTime,
              let oll = currentOLLSolveTime,
              let pll = currentPLLSolveTime else {
            return false
        }

        let currentTotal = cross + f2l + oll + pll

        for solve in solves {
            let total = solve.crossSolveTime + solve.f2LSolveTime + solve.ollSolveTime + solve.pllSolveTime
            if total <= currentTotal {
                return false // Found a time that's better or equal
            }
        }

        return true // No better time found → this is a new PB
    }
    @State var isNewCrossPBAttached = false
    @State var isNewF2LPBAttached = false
    @State var isNewOLLPBAttached = false
    @State var isNewPLLPBAttached = false
    @State var isNewTotalPBAttached = false
    @State private var confettiCounter = 0
    @State var cross = false
    @State var f2L = false
    @State var oll = false
    @State var pll = false
    
    @State private var selectedPhase: CFOPPhase = .total
    
    var formattedTime: String {
        let totalTime: TimeInterval

        if finished {
            let cross = currentCrossSolveTime ?? 0
            let f2l = currentF2LSolveTime ?? 0
            let oll = currentOLLSolveTime ?? 0
            let pll = currentPLLSolveTime ?? 0
            totalTime = cross + f2l + oll + pll
        } else {
            totalTime = solveTime
        }

        let totalMilliseconds = Int(totalTime * 100)
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
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.yellow)
                .onTapGesture {
                    if isSolving {
                        stopSolve()
                    }
                    editCount = false
                }
            if !isInspecting && !isSolving {
                SolveCountButton(model: solveCountModel, editCount: $editCount)
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
                    if (!worldRecord) {
                        if isNewCrossPB || isNewCrossPBAttached {
                            Text("New cross personal best! 🎉")
                                .font(.title2)
                                .onAppear {
                                    confettiCounter += 1
                                    isNewCrossPBAttached = true
                                }
                        }
                        if isNewF2LPB || isNewF2LPBAttached {
                            Text("New F2L personal best! 🎉")
                                .font(.title2)
                                .onAppear {
                                    confettiCounter += 1
                                    isNewF2LPBAttached = true
                                }
                        }
                        if isNewOLLPB || isNewOLLPBAttached {
                            Text("New OLL personal best! 🎉")
                                .font(.title2)
                                .onAppear {
                                    confettiCounter += 1
                                    isNewOLLPBAttached = true
                                }
                        }
                        if isNewPLLPB || isNewPLLPBAttached {
                            Text("New PLL personal best! 🎉")
                                .font(.title2)
                                .onAppear {
                                    confettiCounter += 1
                                    isNewPLLPBAttached = true
                                }
                        }
                    }
                    if worldRecord {
                        Text("NEW WORLD RECORD!!")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.red)
                    }
                    if isNewTotalPB || isNewTotalPBAttached {
                        Text("New personal best time! 🎉")
                            .font(.title2)
                            .onAppear {
                                confettiCounter += 1
                                isNewTotalPBAttached = true
                            }
                    }
                    
                    if isSolving {
                        if cross {
                            Text("CROSS")
                                .font(.system(size: 70))
                        }
                        if f2L {
                            Text("F2L")
                                .font(.system(size: 70))
                        }
                        if oll {
                            Text("OLL")
                                .font(.system(size: 70))
                        }
                        if pll {
                            Text("PLL")
                                .font(.system(size: 70))
                        }
                    }
                    
                    if finished {
                        HStack {
                            if let cross = currentCrossSolveTime {
                                let avg = Array(solves.prefix(5)).map { $0.crossSolveTime }.average()
                                Text("Cross: ") +
                                Text("\(cross, specifier: "%.2f")")
                                    .bold()
                                    .foregroundColor(colorForTime(cross, average: avg))
                            }
                            if let f2l = currentF2LSolveTime {
                                let avg = Array(solves.prefix(5)).map { $0.f2LSolveTime }.average()
                                Text("F2L: ") +
                                Text("\(f2l, specifier: "%.2f")")
                                    .bold()
                                    .foregroundColor(colorForTime(f2l, average: avg))
                            }
                            if let oll = currentOLLSolveTime {
                                let avg = Array(solves.prefix(5)).map { $0.ollSolveTime }.average()
                                Text("OLL: ") +
                                Text("\(oll, specifier: "%.2f")")
                                    .bold()
                                    .foregroundColor(colorForTime(oll, average: avg))
                            }
                            if let pll = currentPLLSolveTime {
                                let avg = Array(solves.prefix(5)).map { $0.pllSolveTime }.average()
                                Text("PLL: ") +
                                Text("\(pll, specifier: "%.2f")")
                                    .bold()
                                    .foregroundColor(colorForTime(pll, average: avg))
                            }
                        }
                    }
                    
                    Text(formattedTime)
                        .font(.system(size: 80))
                        .monospacedDigit()
                        .padding()
                        .onTapGesture {
                            if isSolving {
                                stopSolve()
                            }
                        }
                }
                
                if !isInspecting && !isSolving {
                    ZStack {
                        if !finished {
                            Text(scramble)
                                .font(.title)
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
                        scramble = ""
                        isNewCrossPBAttached = false
                        isNewF2LPBAttached = false
                        isNewOLLPBAttached = false
                        isNewPLLPBAttached = false
                        isNewTotalPBAttached = false
                        currentCrossSolveTime = nil
                        currentF2LSolveTime = nil
                        currentOLLSolveTime = nil
                        currentPLLSolveTime = nil
                        currentTotalSolveTime = nil
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
                } // save, memo
            }
            .onTapGesture {
                if isSolving {
                    stopSolve()
                }
            }
            .padding()
            
            if listView {
                VStack(spacing: 0) {
                    // CFOP Phase Picker
                    Picker("Phase", selection: $selectedPhase) {
                        ForEach(CFOPPhase.allCases) { phase in
                            Text(phase.rawValue).tag(phase)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()

                    // Personal Best for selected phase
                    let phaseTimes: [Double] = solves.compactMap { solve in
                        let memo = solve.memo
                        switch selectedPhase {
                        case .total: return solve.crossSolveTime + solve.f2LSolveTime + solve.ollSolveTime + solve.pllSolveTime
                        case .cross: return solve.crossSolveTime
                        case .f2l: return solve.f2LSolveTime
                        case .oll:
                            if memo.contains("OLL skip") {
                                return nil
                            } else {
                                return solve.ollSolveTime
                            }
                        case .pll:
                            if memo.contains("PLL skip") {
                                return nil
                            } else {
                                return solve.pllSolveTime
                            }
                        }
                    }

                    if let personalBest = phaseTimes.min() {
                        HStack {
                            Text("Personal Best (\(selectedPhase.rawValue)):")
                                .font(.title2)
                                .bold()
                            Text("\(personalBest, specifier: "%.2f")")
                                .font(.title)
                                .bold()
                        }
                    }

                    // Average of last 5 for selected phase
                    if !solves.isEmpty {
                        let recentPhaseTimes = solves.prefix(5).map { solve in
                            switch selectedPhase {
                            case .total: return solve.crossSolveTime + solve.f2LSolveTime + solve.ollSolveTime + solve.pllSolveTime
                            case .cross: return solve.crossSolveTime
                            case .f2l: return solve.f2LSolveTime
                            case .oll: return solve.ollSolveTime
                            case .pll: return solve.pllSolveTime
                            }
                        }

                        let average = recentPhaseTimes.reduce(0, +) / Double(recentPhaseTimes.count)

                        HStack {
                            Text("Avg of Last \(recentPhaseTimes.count) (\(selectedPhase.rawValue)):")
                                .font(.title2)
                                .bold()
                            Text("\(average, specifier: "%.2f")")
                                .font(.title)
                                .bold()
                        }
                    }

                    // Chart for selected phase
                    // Precompute values before the Chart view
                    let chartValues: [Double] = solves.map { solve in
                        switch selectedPhase {
                        case .total:
                            return solve.crossSolveTime + solve.f2LSolveTime + solve.ollSolveTime + solve.pllSolveTime
                        case .cross:
                            return solve.crossSolveTime
                        case .f2l:
                            return solve.f2LSolveTime
                        case .oll:
                            return solve.ollSolveTime
                        case .pll:
                            return solve.pllSolveTime
                        }
                    }

                    let minY = max((chartValues.min() ?? 0) - 1, 0)
                    let maxY = (chartValues.max() ?? 0) + 1

                    Chart {
                        ForEach(Array(chartValues.reversed().enumerated()), id: \.offset) { index, value in
                            LineMark(
                                x: .value("Solve #", index + 1),
                                y: .value("Time", value)
                            )
                            .foregroundStyle(.blue)
                            .interpolationMethod(.linear)
                            .symbol(Circle())
                        }
                    }
                    .chartYScale(domain: minY...maxY)
                    .chartXScale(domain: 0...chartValues.count + 1)
                    .frame(height: 200)
                    .padding(.horizontal)

                    // Total solves
                    Text("Total Solves: \(solves.count)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding()

                    // List of solves (showing only selected phase time)
                    List {
                        ForEach(solves) { solve in
                            let phaseTime = phaseTime(for: solve, phase: selectedPhase)

                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Time (\(selectedPhase.rawValue)): ")
                                    Text("\(phaseTime, specifier: "%.2f")")
                                        .font(.title)
                                        .bold()
                                }
                                if !solve.memo.isEmpty {
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


                    Button("Done") {
                        listView = false
                    }
                    .padding()
                }
                .scrollContentBackground(.hidden)
                .background(Color.yellow)
            }
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
            cross = true
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
            if cross {
                cross = false
                currentCrossSolveTime = solveTime
                f2L = true
            }
            else if f2L {
                f2L = false
                currentF2LSolveTime = solveTime
                oll = true
            }
            else if oll {
                oll = false
                currentOLLSolveTime = solveTime
                pll = true
            }
            else if pll {
                pll = false
                currentPLLSolveTime = solveTime
                finished = true
                isSolving = false
                // Check for world record
                let crossTime = currentCrossSolveTime ?? 0
                let f2lTime = currentF2LSolveTime ?? 0
                let ollTime = currentOLLSolveTime ?? 0
                let pllTime = currentPLLSolveTime ?? 0
                let total = crossTime + f2lTime + ollTime + pllTime
                if total <= worldRecordTime {
                    worldRecord = true
                    confettiCounter += 1
                }
                solveCountModel.count += 1
            }
            if isSolving {
                startSolve()
            }
        }
    }
    
    func saveTime() {
        let solve = CFOPSolveTime(crossSolveTime: currentCrossSolveTime ?? 66, f2LSolveTime: currentF2LSolveTime ?? 66, ollSolveTime: currentOLLSolveTime ?? 66, pllSolveTime: currentPLLSolveTime ?? 66, memo: memo)
        modelContext.insert(solve)
        memo = ""
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
    
    func phaseTime(for solve: CFOPSolveTime, phase: CFOPPhase) -> TimeInterval {
        switch phase {
        case .total:
            return solve.crossSolveTime + solve.f2LSolveTime + solve.ollSolveTime + solve.pllSolveTime
        case .cross: return solve.crossSolveTime
        case .f2l: return solve.f2LSolveTime
        case .oll: return solve.ollSolveTime
        case .pll: return solve.pllSolveTime
        }
    }
    
    func colorForTime(_ time: Double, average: Double) -> Color {
        let epsilon = 0.0001 // small buffer to avoid floating point issues

        if time < average - epsilon {
            return .blue // Faster than average
        } else {
            // Slower than average
            let maxExpectedDiff = 10.0 // seconds above average before full black
            let diff = min(time - average, maxExpectedDiff)
            let darkness = 1.0 - (diff / maxExpectedDiff) // 1 = full color, 0 = black

            // Brownish RGB base
            let baseRed: Double = 162.0 / 255.0
            let baseGreen: Double = 107.0 / 255.0
            let baseBlue: Double = 52.0 / 255.0
            // https://www.rapidtables.com/web/color/RGB_Color.html
            // to dial in the color

            return Color(
                red: baseRed * darkness,
                green: baseGreen * darkness,
                blue: baseBlue * darkness
            )
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

enum CFOPPhase: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    
    case total = "Total"
    case cross = "Cross"
    case f2l = "F2L"
    case oll = "OLL"
    case pll = "PLL"
}

extension Array where Element == Double {
    func average() -> Double {
        guard !isEmpty else { return 0 }
        return reduce(0, +) / Double(count)
    }
}

#Preview {
    CFOPStepTimerView()
}
