//
//  ContentView.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 2025-03-20.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @EnvironmentObject var solveCountModel: SolveCountModel
    @EnvironmentObject var connectivity: PhoneConnectivity
    let color = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    @State var editCount = false
    // Start with empty array; load from UserDefaults if available
    @State private var needsWorkArrayMain: [Algorithm] = []
    var categories: [Category] = []

    init() {
        if let data = UserDefaults.standard.data(forKey: "needsWork"),
           let decoded = try? JSONDecoder().decode([Algorithm].self, from: data) {
            _needsWorkArrayMain = State(initialValue: decoded)
        }
        categories = [
            Category(name: "Simple OLL", algorithms: [
                Algorithm(name: "Lshape", algorithm: "F U R U' R' F'", note: "6 times"),
                Algorithm(name: "line", algorithm: "F R U R' U' F'", note: "6 times"),
                Algorithm(name: "dot", algorithm: "gR U2 (R2' gF R F') U2\n(R' F R F')", note: "18 times"),
                Algorithm(name: "fishRight", algorithm: "(L' U2 L) U (L' U L)", note: "6 times"),
                Algorithm(name: "fishLeft", algorithm: "(R U2 R') U' (R U' R')", note: "6 times"),
                Algorithm(name: "diagonalLeft", algorithm: "F' (r U R' U') (gr' F R)", note: "3 times"),
                Algorithm(name: "Tout90", algorithm: "(gr U R' U') (gr' F R F')", note: "3 times"),
                Algorithm(name: "crossMan90", algorithm: "R U2 (R2' U' R2 U')\n(R2' U2 R)", note: "6 times"),
                Algorithm(name: "cross", algorithm: "(gR U R') gU (R U' R') U\n(R U2 R')", note: "3 times"),
                Algorithm(name: "Tdown", algorithm: "R2 D (R' U2 R) D'\n(R' U2 R')", note: "3 times")
            ]),
            Category(name: "Simple PLL", algorithms: [
                Algorithm(name: "headlights", algorithm: "x (R2 D2) (R U R') D2\n(R U' R)", note: "3 times"),
                Algorithm(name: "noHL", algorithm: "F R U' R' U' R U R' F' (R U R' U') (gR' F R F')", note: "2 times"),
                Algorithm(name: "cwEdges", algorithm: "M2 U' M U2 M' U' M2", note: "3 times"),
                Algorithm(name: "ccwEdges", algorithm: "M2 U M U2 M' U M2", note: "3 times"),
                Algorithm(name: "swap180", algorithm: "(M2 U' M2) U2\n(M2 U' M2)", note: "2 times"),
                Algorithm(name: "swapAdj", algorithm: "M' U' M2 U' M2\nU' M' U2 M2 U", note: "2 times")
            ]),
            Category(name: "Full PLL", algorithms: [
                Algorithm(name: "F", algorithm: "R' U' F' R U R' U' R' F\nR2 U' R' U' R U R' U R", note: "2 times"),
                Algorithm(name: "F mirrored", algorithm: "L U F L' U' L U L F'\nL2 U L U L' U' L U' L'", note: "2 times"),
                Algorithm(name: "Ga", algorithm: "D' R2 U R' U R' U' R U' R2 (U' D) R' U R", note: "4 times"),
                Algorithm(name: "Gb", algorithm: "R' U' R (U D') R2 U R' U R U' R U' R2 D", note: "4 times"),
                Algorithm(name: "Gc", algorithm: "D L2 U' L U' L U L' U L2 (U D') L U' L'", note: "4 times"),
                Algorithm(name: "Gd", algorithm: "L U L' (U' D) L2 U' L U' L' U L' U L2 D'", note: "4 times"),
                // Algorithm(name: "Ga", algorithm: "y R2' u (gR' U R' U') (R u' R2) y' (gR' U R)", note: "3 times"),
                // Algorithm(name: "Gb", algorithm: "(R' U' R) y R2 u (gR' U R U') (gR u' R2)", note: "4 times"),
                // Algorithm(name: "Gc", algorithm: "y' L2 u' (gL U' L U) (L' u L2) y (gL U' L')", note: "3 times"),
                // Algorithm(name: "Gd", algorithm: "(L U L') y' L2 u' (gL U' L' U) (gL' u L2)", note: "4 times"),
                Algorithm(name: "H", algorithm: "(M2 U' M2) U2\n(M2 U' M2)", note: "2 times"),
                Algorithm(name: "Z", algorithm: "M' U' M2 U' M2\nU' M' U2 M2 U", note: "2 times"),
                Algorithm(name: "Z mirrored", algorithm: "M' U M2 U M2\nU M' U2 M2 U'", note: "2 times"),
                Algorithm(name: "Ua", algorithm: "M2 U M U2 M' U M2", note: "3 times"),
                Algorithm(name: "Ub", algorithm: "M2 U' M U2 M' U' M2", note: "3 times"),
                Algorithm(name: "Aa", algorithm: "x z' R2 U2 (R' D' R) U2 (R' D R') z x'", note: "3 times"),
                Algorithm(name: "Aa mirrored", algorithm: "x z L2 U2 (L D L') U2 (L D' L) z' x'", note: "3 times"),
                Algorithm(name: "Ab", algorithm: "x (R2 D2) (R U R') D2\n(R U' R) x'", note: "3 times"),
                Algorithm(name: "Ab mirrored", algorithm: "x (L2 D2) (L' U' L) D2\n(L' U L') x'", note: "3 times"),
                Algorithm(name: "E", algorithm: "R2 U R' U' y (R U R' U') (R U R' U') (R U R') y' (R U' R2')", note: "2 times"),
                Algorithm(name: "Na", algorithm: "(R U R' U) (R U R' F') (R U R' U') R' F\nR2 U' R' U2 (R U' R')", note: "2 times"),
                Algorithm(name: "Nb", algorithm: "(L' U' L U') (L' U' L F) (L' U' L U) L F'\nL2 U L U2 (L' U L)", note: "2 times"),
                Algorithm(name: "T", algorithm: "(R U R' U') R' F\nR2 U' R' U' R U R' F'", note: "2 times"),
                Algorithm(name: "T mirrored", algorithm: "(L' U' L U) L F'\nL2 U L U L' U' L F", note: "2 times"),
                Algorithm(name: "Y", algorithm: "(F R U' R') U' (R U R' F') (R U R' U') (gR' F R F')", note: "2 times"),
                Algorithm(name: "Y mirrored", algorithm: "(F' L' U L) U (L' U' L F) (L' U' L U) (gL F' L' F)", note: "2 times"),
                Algorithm(name: "V", algorithm: "R2 D' R2' U R2 (U' D) R D' R D R' U R U' R", note: "2 times"),
                Algorithm(name: "V mirrored", algorithm: "L2 D L2 U' L2 (U D') L' D L' D' L U' L' U L'", note: "2 times"),
                Algorithm(name: "Ja", algorithm: "L' U' L F (L' U' L U) L F' L2 U L U", note: "2 times"),
                Algorithm(name: "Jb", algorithm: "R U R' F' (R U R' U') R' F R2 U' R' U'", note: "2 times"),
                Algorithm(name: "Ra", algorithm: "(L U2 L') U2 L F' (L' U' L U) gL F L2 U", note: "2 times"),
                Algorithm(name: "Rb", algorithm: "(R' U2 R) U2 R' F (R U R' U') gR' F' R2 U'", note: "2 times"),
            ]),
            Category(name: "F2L", algorithms: [
                Algorithm(name: "corner edge top 1", algorithm: "(U' R U') (R' U R) U R'", note: "", hasVid: true),
                Algorithm(name: "corner edge top 2", algorithm: "(d R' U) (R U' R') U' R", note: "", hasVid: true),
                Algorithm(name: "corner edge top 3", algorithm: "(U' R U) (R' U R) U R'", note: "", hasVid: true),
                Algorithm(name: "corner edge top 4", algorithm: "y (U L' U') (L U' L') U' L", note: "", hasVid: true),
                Algorithm(name: "corner edge top 5", algorithm: "y U (L' U2 L) d' (L U L')", note: "", hasVid: true),
                Algorithm(name: "corner edge top 6", algorithm: "U' (R U2 R') d (R' U' R)", note: "", hasVid: true),
                Algorithm(name: "corner edge top 7", algorithm: "(R U' R' U) d (R' U' R)", note: "", hasVid: true),
                Algorithm(name: "corner edge top 8", algorithm: "y (L' U L U') d' (L U L')", note: "", hasVid: true),
                Algorithm(name: "corner edge top 9", algorithm: "y (U L' U2 L) (U L' U2 L)", note: "", hasVid: true),
                Algorithm(name: "corner edge top 10", algorithm: "(U' R U2 R') (U' R U2 R')", note: "", hasVid: true),
                Algorithm(name: "corner edge top 11", algorithm: "y (U L' U' L) (U L' U2 L)", note: "", hasVid: true),
                Algorithm(name: "corner edge top 12", algorithm: "(U' R U R') (U' R U2 R')", note: "", hasVid: true),
                
                Algorithm(name: "corner up edge top 1", algorithm: "(R U2 R' U') (R U R')", note: "", hasVid: true),
                Algorithm(name: "corner up edge top 2", algorithm: "y (L' U2 L U) (L' U' L)", note: "", hasVid: true),
                Algorithm(name: "corner up edge top 3", algorithm: "(U R U2 R') (U R U' R')", note: "", hasVid: true),
                Algorithm(name: "corner up edge top 4", algorithm: "(U' F' U2 F) (U' F' U F)", note: "", hasVid: true),
                Algorithm(name: "corner up edge top 5", algorithm: "U2 (R U R' U) (R U' R')", note: "", hasVid: true),
                Algorithm(name: "corner up edge top 6", algorithm: "U2 (F' U' F U') (F' U F)", note: "", hasVid: true),
                Algorithm(name: "corner up edge top 7", algorithm: "(U R U' R') (U' R U' R') (U R U' R')", note: "", hasVid: true),
                Algorithm(name: "corner up edge top 8", algorithm: "y (U' L' U L) (U L' U L) (U' L' U L)", note: "", hasVid: true),
                
                Algorithm(name: "corner top edge middle 1", algorithm: "y (U L' U L) (U L' U2 L)", note: "", hasVid: true),
                Algorithm(name: "corner top edge middle 2", algorithm: "(U' R U' R') (U' R U2 R')", note: "", hasVid: true),
                Algorithm(name: "corner top edge middle 3", algorithm: "y (U L' U' L) (d' L U L')", note: "", hasVid: true),
                Algorithm(name: "corner top edge middle 4", algorithm: "(U' R U R') (d R' U' R)", note: "", hasVid: true),
                Algorithm(name: "corner top edge middle 5", algorithm: "(R U' R') (d R' U R)", note: "", hasVid: true),
                Algorithm(name: "corner top edge middle 6", algorithm: "(R U R' U') (R U R' U') (R U R')", note: "", hasVid: true),
                
                Algorithm(name: "corner bottom edge top 1", algorithm: "(U R U' R') (U' F' U F)", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge top 2", algorithm: "(U' F' U F) (U R U' R')", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge top 3", algorithm: "(F' U F) (U' F' U F)", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge top 4", algorithm: "(R U' R') (U R U' R')", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge top 5", algorithm: "(R U R') (U' R U R')", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge top 6", algorithm: "y (L' U' L U) L' U' L", note: "", hasVid: true),
                
                Algorithm(name: "corner bottom edge middle 1", algorithm: "(R U' R' U) R U2 R' (U R U' R')", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge middle 2", algorithm: "(R U' R' U') (R U R' U') (R U2 R')", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge middle 3", algorithm: "(R U R' U') (R U' R') U d (R' U' R)", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge middle 4", algorithm: "(R U' R') d (R' U' R U') (R' U' R)", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge middle 5", algorithm: "(R U' R' d R' U2 R) (U R' U2 R)", note: "", hasVid: true),
            ]),
            Category(name: "4X4 Parity", algorithms: [
                Algorithm(name: "four inline", algorithm: "Rw U2, X, Rw U2, Rw U2,\nRw' U2, Lw U2, Rw' U2,\nRw U2, Rw' U2, Rw'", note: "2 times"), //verified
                Algorithm(name: "single edge", algorithm: "r' U2 l F2 l' F2 r2 U2\nr U2 r' U2 F2 r2 F2", note: "2 times"), //verified
                Algorithm(name: "opposite edges", algorithm: "r2 U2 r2 Uw2 r2 u2", note: "2 times"), //verified
                Algorithm(name: "adjacent edges", algorithm: "(R' U R U') r2 U2 r2 Uw2\nr2 u2 (U R' U' R)", note: "2 times"), //verified
            ]),
            Category(name: "Needs Work", algorithms: needsWorkArrayMain)
        ]
    }
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundStyle(.yellow)
                    .ignoresSafeArea()
                VStack {
                    Text("Rubik's Cube Trainer!")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    Spacer()
                    ScrollView(showsIndicators: false) {
                        VStack {
                            NavigationLink(destination: TimerView()) {
                                Text("Timer")
                                    .capsuleButtonStyle()
                            }
                            
                            NavigationLink(destination: CFOPStepTimerView()) {
                                Text("CFOP Step Timer")
                                    .capsuleButtonStyle()
                            }
                            
                            //                        NavigationLink(destination: AllAlgorithmsView(categories: categories)) {
                            //                            Text("All Algorithms")
                            //                                .capsuleButtonStyle()
                            //                        }
                            
                            //                        NavigationLink(destination: IndividualCategoryView(category: categories.first { $0.name == "Simple OLL" }!)) {
                            //                            Text("Simple OLL")
                            //                                .capsuleButtonStyle()
                            //                        }
                            //
                            //                        NavigationLink(destination: IndividualCategoryView(category: categories.first { $0.name == "Simple PLL" }!)) {
                            //                            Text("Simple PLL")
                            //                                .capsuleButtonStyle()
                            //                        }
                            NavigationLink(destination: IndividualCategoryView(category: categories.first { $0.name == "F2L" }!)) {
                                Text("F2L")
                                    .capsuleButtonStyle()
                            }
                            
                            NavigationLink(destination: ListView(category: categories.first { $0.name == "F2L" }!)) {
                                Text("F2L List")
                                    .capsuleButtonStyle()
                            }
                            
                            NavigationLink(destination: AdvancedF2LView()) {
                                Text("Advanced F2L")
                                    .capsuleButtonStyle(color: .red)
                            }
                            
                            if !needsWorkArrayMain.isEmpty {
                                NavigationLink(
                                        destination: IndividualCategoryView(
                                            category: Category(name: "Needs Work", algorithms: needsWorkArrayMain)
                                        )
                                    ) {
                                    Text("Weak Algorithms (\(needsWorkArrayMain.count))")
                                        .capsuleButtonStyle()
                                }
                            }
                            
                            NavigationLink(destination: FullOLLView()) {
                                Text("Full OLL")
                                    .capsuleButtonStyle(color: .red)
                            }
                            
                            NavigationLink(destination: IndividualCategoryView(category: categories.first { $0.name == "Full PLL" }!)) {
                                Text("Full PLL")
                                    .capsuleButtonStyle()
                            }
                            
                            NavigationLink(destination: ListView(category: categories.first { $0.name == "Full PLL" }!)) {
                                Text("Full PLL List")
                                    .capsuleButtonStyle()
                            }
                            
                            NavigationLink(destination: MegaminxView()) {
                                Text("Megaminx")
                                    .capsuleButtonStyle()
                            }
                            
                            NavigationLink(destination: IndividualCategoryView(category: categories.first { $0.name == "4X4 Parity" }!)) {
                                Text("4X4 Parity")
                                    .capsuleButtonStyle()
                            }
                            
                            NavigationLink(destination: ListView(category: categories.first { $0.name == "4X4 Parity" }!)) {
                                Text("4X4 Parity List")
                                    .capsuleButtonStyle()
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .onTapGesture {
                        editCount = false
                    }
                    Spacer()
                }
                .padding()
                SolveCountButton(editCount: $editCount)
                    .padding(.top, 15)
            }
            .onAppear {
                if let data = UserDefaults.standard.data(forKey: "needsWork"),
                   let decoded = try? JSONDecoder().decode([Algorithm].self, from: data) {
                    needsWorkArrayMain = decoded
                }
                if WCSession.default.isReachable {
                    let solveCount = solveCountModel.count
                    WCSession.default.sendMessage(["solveCount": solveCount]) { response in
                        print("✅ Watch responded: \(response)")
                    } errorHandler: { error in
                        print("❌ Failed to send message: \(error.localizedDescription)")
                    }
                } else {
                    print("⚠️ Watch not reachable right now")
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [SolveTime.self, CFOPSolveTime.self])
        .environmentObject(SolveCountModel())
}
