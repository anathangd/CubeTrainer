//
//  FullOLLView.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 7/12/25.
//

import SwiftUI

struct FullOLLView: View {
    @State private var selectedCategoryForIndividual: Category? = nil
    @State private var showIndividualView = false
    @State private var selectedCategoryForList: Category? = nil
    @State private var showListView = false
    var totalAlgorithmCount: Int {
        categories.reduce(0) { $0 + $1.algorithms.count }
    }
    let categories: [Category] = [
        Category(name: "Crosses", algorithms: [
            Algorithm(name: "fishRight", algorithm: "(L' U2 L) U (L' U L)", note: "6 times"),
            Algorithm(name: "fishLeft", algorithm: "(R U2 R') U' (R U' R')", note: "6 times"),
            Algorithm(name: "diagonalLeft", algorithm: "F' (r U R' U') (r' F R)", note: "3 times"),
            Algorithm(name: "diagonalLeftMirrored", algorithm: "F (l' U' L U) (l F' L')", note: "3 times"),
            Algorithm(name: "Tout90", algorithm: "(r U R' U') (r' F R F')", note: "3 times"),
            Algorithm(name: "Tout90Mirrored", algorithm: "(l' U' L U) (l F' L' F)", note: "3 times"),
            Algorithm(name: "crossMan90", algorithm: "R U2 (R2' U' R2 U')\n(R2' U2 R)", note: "6 times"),
            Algorithm(name: "crossMan90Mirrored", algorithm: "L' U2 (L2 U L2 U) (L2 U2 L')", note: "6 times"),
            Algorithm(name: "cross", algorithm: "(R U R') U (R U' R') U\n(R U2 R')", note: "3 times"),
            Algorithm(name: "Tdown", algorithm: "R2 D (R' U2 R) D'\n(R' U2 R')", note: "3 times")
        ]),
        Category(name: "Dots", algorithms: [
            Algorithm(name: "dots 1", algorithm: "(R U2 R') (R' F R F') U2 (R' F R F')", note: "18 times"),
            Algorithm(name: "dots 2", algorithm: "F (R U R' U') F' f (R U R' U') f'", note: "6 times"),
            Algorithm(name: "dots 2 mirrored", algorithm: "F' (L' U' L U) F f' (L' U' L U) f", note: "6 times"),
            Algorithm(name: "dots 3", algorithm: "f (R U R' U') f' U F (R U R' U') F'", note: "4 times"),
            Algorithm(name: "dots 3 mirrored", algorithm: "f' (L' U' L U) f U' F' (L' U' L U) F", note: "4 times"),
            Algorithm(name: "dots 4", algorithm: "f (R U R' U') f' U' F (R U R' U') F'", note: "4 times"),
            Algorithm(name: "dots 4 mirrored", algorithm: "f' (L' U' L U) f U F' (L' U' L U) F", note: "4 times"),
            Algorithm(name: "dots 5", algorithm: "M U (R U R' U') M' (R' F R F')", note: "12 times"),
            Algorithm(name: "dots 6", algorithm: "F (R U R' U) y' R' U2 (R' F R F')", note: "4 times"),
            Algorithm(name: "dots 7", algorithm: "(R U R' U) (R' F R F') U2 (R' F R F')", note: "18 times"),
            Algorithm(name: "dots 7 mirrored", algorithm: "(L' U' L U') (L F' L' F) U2 (L F' L' F)", note: "18 times"),
            Algorithm(name: "dots 8", algorithm: "M U (R U R' U') M2 (U R U' r')", note: "4 times")
        ]),
        Category(name: "All Corners", algorithms: [
            Algorithm(name: "all corners 1", algorithm: "(R U R' U') M' (U R U' r')", note: "3 times"),
            Algorithm(name: "all corners 2", algorithm: "M' U' M U2' M' U' M", note: "3 times"),
            Algorithm(name: "all corners 2 mirrored", algorithm: "M' U M U2 M' U M", note: "3 times")
        ]),
        Category(name: "Lines", algorithms: [
            Algorithm(name: "line 1", algorithm: "R U2 R2 (U' R U' R') U2 (F R F')", note: "18 times"),
            Algorithm(name: "line 2", algorithm: "(R U R' U) R d' R U' R' F'", note: "12 times"),
            Algorithm(name: "line 2 mirrored", algorithm: "(L' U' L U') L' d L' U L F", note: "12 times"),
            Algorithm(name: "line 3", algorithm: "f (R U R' U') (R U R' U') f'", note: "3 times"),
            Algorithm(name: "line 3 mirrored", algorithm: "f' (L' U' L U) (L' U' L U) f", note: "3 times"),
            Algorithm(name: "line 4", algorithm: "F (R U R' U') R F' (r U R' U') r'", note: "9 times")
        ]),
        Category(name: "Ts", algorithms: [
            Algorithm(name: "T1", algorithm: "F (R U R' U') F'", note: "6 times"),
            Algorithm(name: "T1 mirrored", algorithm: "F' (L' U' L U) F", note: "6 times"),
            Algorithm(name: "T2", algorithm: "(R U R' U') (R' F R F')", note: "3 times"),
            Algorithm(name: "T2 mirrored", algorithm: "(L' U' L U) (L F' L' F)", note: "3 times")
        ]),
        Category(name: "Zs", algorithms: [
            Algorithm(name: "Z1", algorithm: "R' F (R U R' U') F' U R", note: "12 times"),
            Algorithm(name: "Z2", algorithm: "L F' (L' U' L U) F U' L'", note: "12 times")
        ]),
        Category(name: "Big Ls", algorithms: [
            Algorithm(name: "L1", algorithm: "F' (U' L' U L2) F (L' U' L' U L)", note: "9 times"),
            Algorithm(name: "L2", algorithm: "F (U R U' R2) F' (R U R U' R')", note: "9 times"),
            Algorithm(name: "L3", algorithm: "r U r' (R U R' U') r U' r'", note: "6 times"),
            Algorithm(name: "L4", algorithm: "l' U' l (L' U' L U) l' U l", note: "6 times")
        ]),
        Category(name: "Cs", algorithms: [
            Algorithm(name: "C1", algorithm: "R' U' (R' F R F') U R", note: "6 times"),
            Algorithm(name: "C1 mirrored", algorithm: "L U (L F' L' F) U' L'", note: "6 times"),
            Algorithm(name: "C2", algorithm: "(R U R' U') x D' R' U R (U' D) x'", note: "3 times")
        ]),
        Category(name: "Ws", algorithms: [
            Algorithm(name: "W1", algorithm: "(R U R' U) (R U' R' U') (R' F R F')", note: "6 times"),
            Algorithm(name: "W2", algorithm: "(L' U' L U') (L' U L U) (L F' L' F)", note: "6 times")
        ]),
        Category(name: "Ps", algorithms: [
            Algorithm(name: "P1", algorithm: "f (R U R' U') f'", note: "6 times"),
            Algorithm(name: "P2", algorithm: "f' (L' U' L U) f", note: "6 times"),
            Algorithm(name: "P3", algorithm: "F' U' L' U F l' U' L U l", note: "3 times"),
            Algorithm(name: "P4", algorithm: "F U R U' F' r U R' U' r'", note: "3 times")
        ]),
        Category(name: "Squares", algorithms: [
            Algorithm(name: "square 1", algorithm: "(R U2 R') (R' F R F') (R U2 R')", note: "6 times"),
            Algorithm(name: "square 1 mirrored", algorithm: "(L' U2 L) (L F' L' F) (L' U2 L)", note: "6 times"),
            Algorithm(name: "square 2", algorithm: "F R' F' R U R U' R'", note: "3 times"),
            Algorithm(name: "square 2 mirrored", algorithm: "F' L F L' U' L' U L", note: "3 times"),
            Algorithm(name: "square 3", algorithm: "l' U2 L U L' U l", note: "6 times"),
            Algorithm(name: "square 4", algorithm: "r U2 R' U' R U' r'", note: "6 times")
        ]),
        Category(name: "Little Ls", algorithms: [
            Algorithm(name: "littleL1", algorithm: "F (R U R' U') (R U R' U') F'", note: "3 times"),
            Algorithm(name: "littleL2", algorithm: "F' (L' U' L U) (L' U' L U) F", note: "3 times"),
            Algorithm(name: "littleL3", algorithm: "R' F R2 B' R2 F' R2 B R'", note: "6 times"),
            Algorithm(name: "littleL4", algorithm: "L F' L2 B L2 F L2 B' L", note: "6 times"),
            Algorithm(name: "littleL5", algorithm: "(l' U' L U') (L' U L U') L' U2 l", note: "3 times"),
            Algorithm(name: "littleL6", algorithm: "(r U R' U) (R U' R' U) R U2' r'", note: "3 times")
        ]),
        Category(name: "Other shapes", algorithms: [
            Algorithm(name: "other 1", algorithm: "F' (L' U' L U) F U' F' (L' U' L U) F", note: "4 times"),
            Algorithm(name: "other 2", algorithm: "F (R U R' U') F' U F (R U R' U') F'", note: "4 times"),
            Algorithm(name: "other 3", algorithm: "(r U R' U) R U2 r'", note: "6 times"),
            Algorithm(name: "other 4", algorithm: "(l' U' L U') L' U2 l", note: "6 times"),
            Algorithm(name: "other 5", algorithm: "(R U R' U) (R' F R F') R U2 R'", note: "6 times"),
            Algorithm(name: "other 6", algorithm: "(L' U' L U') (L F' L' F) L' U2 L", note: "6 times"),
            Algorithm(name: "other 7", algorithm: "(R U R' U') R U' R' F' U' (F R U R')", note: "4 times"),
            Algorithm(name: "other 8", algorithm: "(L' U' L U) L' U L F U (F' L' U' L)", note: "4 times"),
            Algorithm(name: "other 9", algorithm: "(R' F R F') (R' F R F') (R U R' U') (R U R')", note: "4 times"),
            Algorithm(name: "other 10", algorithm: "(L F' L' F) (L F' L' F) (L' U' L U) (L' U' L)", note: "4 times")
        ])
    ]
    var allAlgorithmsCategory: Category {
        Category(
            name: "All Algorithms",
            algorithms: categories.flatMap { $0.algorithms }
        )
    }
    @EnvironmentObject var solveCountModel: SolveCountModel
    @State var editCount = false
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.yellow)
                .ignoresSafeArea()
            VStack {
                Text("Full OLL!")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding(.top, 65)
                Spacer()
                ScrollView(showsIndicators: false) {
                    VStack {
                        NavigationLink(destination: IndividualCategoryView(category: allAlgorithmsCategory)) {
                            Text("All Algorithms (\(totalAlgorithmCount))")
                                .capsuleButtonStyle()
                        }
                        NavigationLink(destination: ListView(category: allAlgorithmsCategory)) {
                            Text("All Algorithms List")
                                .capsuleButtonStyle()
                        }
                        
                        ForEach(categories, id: \.name) { category in
                            Button(action: {
                                selectedCategoryForIndividual = category
                                showIndividualView = true
                            }) {
                                Text("\(category.name) (\(category.algorithms.count))")
                                    .capsuleButtonStyle()
                            }
                            .highPriorityGesture(
                                LongPressGesture().onEnded { _ in
                                    selectedCategoryForList = category
                                    showListView = true
                                    showIndividualView = false
                                }
                            )
                        }                        
                    }
                    .frame(maxWidth: .infinity)
                }
                .onTapGesture {
                    editCount = false
                }
                Spacer()
                // Navigation destinations for category and list
                .navigationDestination(isPresented: $showIndividualView) {
                    if let selectedCategoryForIndividual = selectedCategoryForIndividual {
                        IndividualCategoryView(category: selectedCategoryForIndividual)
                    }
                }
                .navigationDestination(isPresented: $showListView) {
                    if let selectedCategoryForList = selectedCategoryForList {
                        ListView(category: selectedCategoryForList)
                    }
                }
            }
            .ignoresSafeArea()
            SolveCountButton(editCount: $editCount)
                .padding(.top, 15)
        }
    }
}

#Preview {
    FullOLLView()
        .modelContainer(for: [SolveTime.self, CFOPSolveTime.self])
        .environmentObject(SolveCountModel())
}
