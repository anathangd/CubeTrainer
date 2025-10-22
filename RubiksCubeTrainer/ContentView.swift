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
    var isConnected: Bool {
        WCSession.default.isReachable
    }
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
            Category(name: "4X4 Parity", algorithms: [
                Algorithm(name: "four inline", algorithm: "Rw U2, X, Rw U2, Rw U2,\nRw' U2, Lw U2, Rw' U2,\nRw U2, Rw' U2, Rw'", note: "2 times"), //verified
                Algorithm(name: "single edge", algorithm: "r' U2 l F2 l' F2 r2 U2\nr U2 r' U2 F2 r2 F2", note: "2 times"), //verified
                Algorithm(name: "opposite edges", algorithm: "r2 U2 r2 Uw2 r2 u2", note: "2 times"), //verified
                Algorithm(name: "adjacent edges", algorithm: "(R' U R U') r2 U2 r2 Uw2\nr2 u2 (U R' U' R)", note: "2 times"), //verified
            ]),
            Category(name: "Needs Work", algorithms: needsWorkArrayMain)
        ]
    }
    @State var selectedCategoryForList: Category?
    @State var showListView = false
    @State var selectedCategoryForIndividual: Category?
    @State var showIndividualView = false
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundStyle(.yellow)
                    .ignoresSafeArea()
                // Watch connected indicator
                VStack {
                    HStack {
                        Spacer()
                        Text(isConnected ? "✅" : "⚠️")
                            .font(.footnote)
                            .padding(.horizontal, 20)
                            .padding(.top, -10)
                    }
                    Spacer()
                }
                
                VStack {
                    Text("Rubik's Cube Trainer!")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .padding(.top, 65)
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
                            
                            let category = Category(name: "F2L", algorithms: F2LAlgorithms.algorithms)
                                Button(action: {
                                    selectedCategoryForIndividual = category
                                    showIndividualView = true
                                }) {
                                    Text("\(category.name) (\(category.algorithms.count))")
                                        .capsuleButtonStyle()
                                }
                                .highPriorityGesture(
                                    LongPressGesture().onEnded { _ in
                                        showIndividualView = false
                                        selectedCategoryForList = category
                                        showListView = true
                                    }
                                )
                            
                            NavigationLink(destination: AdvancedF2LView()) {
                                Text("Advanced F2L >")
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
                                Text("Full OLL >")
                                    .capsuleButtonStyle(color: .red)
                            }
                            
                            let fullPLL = Category(name: "Full PLL", algorithms: FullPLLAlgorithms.algorithms)
                                Button(action: {
                                    selectedCategoryForIndividual = fullPLL
                                    showIndividualView = true
                                }) {
                                    Text("\(fullPLL.name) (\(fullPLL.algorithms.count))")
                                        .capsuleButtonStyle()
                                }
                                .highPriorityGesture(
                                    LongPressGesture().onEnded { _ in
                                        showIndividualView = false
                                        selectedCategoryForList = fullPLL
                                        showListView = true
                                    }
                                )
                            
                            let pllabridged = Category(name: "PLL Abridged", algorithms: PLLRecognitionAbridgedCases.cases)
                                Button(action: {
                                    selectedCategoryForIndividual = pllabridged
                                    showIndividualView = true
                                }) {
                                    Text("\(pllabridged.name) (\(pllabridged.algorithms.count))")
                                        .capsuleButtonStyle()
                                }
                                .highPriorityGesture(
                                    LongPressGesture().onEnded { _ in
                                        showIndividualView = false
                                        selectedCategoryForList = pllabridged
                                        showListView = true
                                    }
                                )
                            
                            let pllrec = Category(name: "PLL Recognition", algorithms: PLLRecognitionCases.cases)
                                Button(action: {
                                    selectedCategoryForIndividual = pllrec
                                    showIndividualView = true
                                }) {
                                    Text("\(pllrec.name) (\(pllrec.algorithms.count))")
                                        .capsuleButtonStyle()
                                }
                                .highPriorityGesture(
                                    LongPressGesture().onEnded { _ in
                                        showIndividualView = false
                                        selectedCategoryForList = pllrec
                                        showListView = true
                                    }
                                )
                            
                            let ollrec = Category(name: "OLL Recognition", algorithms: OLLRecognitionCases.cases)
                                Button(action: {
                                    selectedCategoryForIndividual = ollrec
                                    showIndividualView = true
                                }) {
                                    Text("\(ollrec.name) (\(ollrec.algorithms.count))")
                                        .capsuleButtonStyle()
                                }
                                .highPriorityGesture(
                                    LongPressGesture().onEnded { _ in
                                        showIndividualView = false
                                        selectedCategoryForList = ollrec
                                        showListView = true
                                    }
                                )
                            
                            if let category = categories.first(where: { $0.name == "4X4 Parity" }),
                               !category.algorithms.isEmpty {
                                Button(action: {
                                    selectedCategoryForIndividual = category
                                    showIndividualView = true
                                }) {
                                    Text("\(category.name) (\(category.algorithms.count))")
                                        .capsuleButtonStyle()
                                }
                                .highPriorityGesture(
                                    LongPressGesture().onEnded { _ in
                                        showIndividualView = false
                                        selectedCategoryForList = category
                                        showListView = true
                                    }
                                )
                            }
                            
                            NavigationLink(destination: MegaminxView()) {
                                Text("Megaminx >")
                                    .capsuleButtonStyle()
                            }
                            
//                            NavigationLink(destination: RoofpigTestView()) {
//                                Text("Roofpig Test >")
//                                    .capsuleButtonStyle(color: .red)
//                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .onTapGesture {
                        editCount = false
                    }
                    Spacer()
                }
                .ignoresSafeArea()
                SolveCountButton(editCount: $editCount)
                    .padding(.top, 15)
            }
            .navigationDestination(isPresented: $showIndividualView) {
                IndividualCategoryView(category: selectedCategoryForIndividual ?? categories.first!)
            }
            .navigationDestination(isPresented: $showListView) {
                ListView(category: selectedCategoryForList ?? categories.first!)
            }
            .onAppear {
                if let data = UserDefaults.standard.data(forKey: "needsWork"),
                   let decoded = try? JSONDecoder().decode([Algorithm].self, from: data) {
                    needsWorkArrayMain = decoded
                    print("✅ Refreshed needsWorkArrayMain: \(decoded.count) items")
                } else {
                    needsWorkArrayMain = []
                    print("⚠️ No needsWork data found")
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
