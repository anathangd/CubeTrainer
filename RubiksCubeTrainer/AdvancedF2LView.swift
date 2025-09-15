//
//  AdvancedF2LView.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 7/27/25.
//

import SwiftUI

struct AdvancedF2LView: View {
    @State private var selectedCategoryForList: Category?
    @State private var showListView = false
    @State private var selectedCategoryForIndividual: Category?
    @State private var showIndividualView = false
    var totalAlgorithmCount: Int {
        categories.reduce(0) { $0 + $1.algorithms.count }
    }
    let categories: [Category] = [
        Category(name: "White up", algorithms: [
           Algorithm(name: "white up 1", algorithm: "U' R' U R2 U' R'", note: "", hasVid: true), // redone
           Algorithm(name: "white up 2", algorithm: "U (R' U R U' R' U' R) y (L' U L)", note: "", hasVid: true), // redone
           Algorithm(name: "white up 3", algorithm: "y U L U' L2 U L", note: "", hasVid: true), // redone
           Algorithm(name: "white up 4", algorithm: "L F' L2 U L U2 F", note: "", hasVid: true), // redone
           Algorithm(name: "white up 5", algorithm: "(R U R' U') R U R' U L U L'", note: "", hasVid: true), // redone
           Algorithm(name: "white up 6", algorithm: "L F' U F L'", note: "", hasVid: true) // redone
           ]),
        Category(name: "White side", algorithms: [
            Algorithm(name: "white side 1", algorithm: "R' U' R2 U R'", note: "", hasVid: true), // redone
            Algorithm(name: "white side 2", algorithm: "y L u L u' L'", note: "", hasVid: true), // redone
            Algorithm(name: "white side 3", algorithm: "U' (L' U' L) (R U' R')", note: "", hasVid: true), // redone
            Algorithm(name: "white side 4", algorithm: "(F U2 F') (R U R')", note: "", hasVid: true), // redone
            Algorithm(name: "white side 5", algorithm: "U (R U R') (L U L')", note: "", hasVid: true), // redone
            Algorithm(name: "white side 6", algorithm: "U2 (R' F R F') (L U L')", note: "", hasVid: true) // redone
        ]),
        Category(name: "White front", algorithms: [
            Algorithm(name: "white front 1", algorithm: "U2 R U R2' U' R2 U R'", note: "", hasVid: true), // redone
            Algorithm(name: "white front 2", algorithm: "R' U2 R F' U' F", note: "", hasVid: true), // redone
            Algorithm(name: "white front 3", algorithm: "y L U L2' U' L", note: "", hasVid: true), // redone
            Algorithm(name: "white front 4", algorithm: "R' u' R' u R", note: "", hasVid: true), // redone
            Algorithm(name: "white front 5", algorithm: "U' R U' R' L U' L'", note: "", hasVid: true), // redone
            Algorithm(name: "white front 6", algorithm: "U2 R B' U' B R'", note: "", hasVid: true) // redone
        ]),
        Category(name: "Wrong corner", algorithms: [
            Algorithm(name: "wrong corner 1", algorithm: "U (R U' R') (L' U L)", note: "", hasVid: true), // redone
            Algorithm(name: "wrong corner 2", algorithm: "y (L' U2 L) U' (L U L')", note: "", hasVid: true), // redone
            Algorithm(name: "wrong corner 3", algorithm: "U2 (R U' R') U (L' U' L)", note: "", hasVid: true), // redone
            Algorithm(name: "wrong corner 4", algorithm: "y U' L' U' L2 U2 L'", note: "", hasVid: true), // redone
            Algorithm(name: "wrong corner 5", algorithm: "R (L' U L) R'", note: "also S' L S", hasVid: true), // redone
            Algorithm(name: "wrong corner 6", algorithm: "U' (R U R') y' (R U R')", note: "", hasVid: true) // redone
        ]),
        Category(name: "Corner left", algorithms: [
            Algorithm(name: "corner left 1", algorithm: "(R U2 R') U (R' U' R)", note: "", hasVid: true), // redone
            Algorithm(name: "corner left 2", algorithm: "y U' (L' U L) (R U' R')", note: "", hasVid: true), // redone
            Algorithm(name: "corner left 3", algorithm: "y U (L' U' L) y (L' U' L)", note: "", hasVid: true), // redone
            Algorithm(name: "corner left 4", algorithm: "y L' (R U' R') L", note: "also S R' S'", hasVid: true), // redone
            Algorithm(name: "corner left 5", algorithm: "U R U R2' U2 R", note: "", hasVid: true), // redone
            Algorithm(name: "corner left 6", algorithm: "R U R' U2 f R f'", note: "", hasVid: true) // redone
        ]),
        Category(name: "Corner back", algorithms: [
            Algorithm(name: "corner back 1", algorithm: "U' (R' F R F') U2 (L U L')", note: "", hasVid: true), // redone
            Algorithm(name: "corner back 2", algorithm: "U (R U' R') y (R' U2 R)", note: "", hasVid: true), // redone
            Algorithm(name: "corner back 3", algorithm: "(R U' R') (L U2 L')", note: "", hasVid: true), // redone
            Algorithm(name: "corner back 4", algorithm: "y L' U' L U' R' U' R", note: "", hasVid: true), // redone
            Algorithm(name: "corner back 5", algorithm: "R U R' U L U L'", note: "", hasVid: true), // redone
            Algorithm(name: "corner back 6", algorithm: "y (L' U L) (R' U2 R)", note: "", hasVid: true) // redone
        ]),
        Category(name: "Corner solved", algorithms: [
            Algorithm(name: "corner solved 1", algorithm: "R2 U' R2' U R2", note: "", hasVid: true), // redone
            Algorithm(name: "corner solved 2", algorithm: "y R' u' R u R", note: "", hasVid: true), // redone
            Algorithm(name: "corner solved 3", algorithm: "y L2' U L2 U' L2'", note: "", hasVid: true),
            Algorithm(name: "corner solved 4", algorithm: "L u L' u' L'", note: "", hasVid: true), // redone
        ]),
        Category(name: "Pair wrong", algorithms: [
            Algorithm(name: "pair wrong 1", algorithm: "(L F' L' F) (R U' R')", note: "", hasVid: true), // redone
            Algorithm(name: "pair wrong 2", algorithm: "R' F R F' L' U L", note: "", hasVid: true), // redone
            Algorithm(name: "pair wrong 3", algorithm: "R (L U2 L') R'", note: "", hasVid: true) // redone
        ]),
        Category(name: "Extra", algorithms: [
            Algorithm(name: "extra 1", algorithm: "R U' R' U' R U R' y U R U' R'", note: "", hasVid: true), // redone
            Algorithm(name: "extra 2", algorithm: "y L' U L U L' U' L y' U' L' U L", note: "", hasVid: true), // redone
            Algorithm(name: "extra 3", algorithm: "R U' R' U R U2 R' y R U' R'", note: "", hasVid: true), // redone
            Algorithm(name: "extra 4", algorithm: "y L' U L U' L' U2 L y' L' U L", note: "", hasVid: true), // redone
            Algorithm(name: "extra 5", algorithm: "R U' R' U' R U' R2' U' R", note: "", hasVid: true), // redone
            Algorithm(name: "extra 6", algorithm: "y L' U L U L' U L2 U L'", note: "", hasVid: true), // redone
            Algorithm(name: "extra 7", algorithm: "R U' R2' U2' R U R' U2' R", note: "", hasVid: true), // redone
            Algorithm(name: "extra 8", algorithm: "y L' U L2 U2 L' U' L U2 L'", note: "", hasVid: true), // redone
            Algorithm(name: "extra 9", algorithm: "R U' R' U' y R U' R' d R' U R", note: "", hasVid: true), // redone
            Algorithm(name: "extra 10", algorithm: "y L' U L U y' L' U L d' L U' L'", note: "", hasVid: true), // redone
            Algorithm(name: "extra 11", algorithm: "R U R' U2' y R U' R' d R' U R", note: "", hasVid: true), // redone
            Algorithm(name: "extra 12", algorithm: "y L' U' L U2 y' L' U L d' L U' L'", note: "", hasVid: true), // redone
            Algorithm(name: "extra 13", algorithm: "R U' R2' U' R d' R U R'", note: "", hasVid: true), // redone
            Algorithm(name: "extra 14", algorithm: "y L' U L2 U L' d L' U' L", note: "", hasVid: true), // redone
            Algorithm(name: "extra 15", algorithm: "R U' R2' U R U R' U2' R", note: "", hasVid: true), // redone
            Algorithm(name: "extra 16", algorithm: "y L' U L2 U' L' U' L U2 L'", note: "", hasVid: true), // redone
            Algorithm(name: "extra 17", algorithm: "L' U2 R U R' U' R U R'", note: "", hasVid: true), // redone
            Algorithm(name: "extra 18", algorithm: "R U R' U2 R' U R2 U' R'", note: "", hasVid: true), // redone
            Algorithm(name: "extra 19", algorithm: "L' U' L y L' U L U' L' U L", note: "", hasVid: true), // redone
            Algorithm(name: "extra 20", algorithm: "R U R' y' R U' R' U R U' R'", note: "", hasVid: true) // redone
        ]),
        Category(name: "Stragglers", algorithms: [
            Algorithm(name: "straggler 1", algorithm: "y R U R' y' R U' R' U R U' R'", note: "", hasVid: true), // redone
            Algorithm(name: "straggler 2", algorithm: "y R U R' y' (R U R' U') R U R'", note: "", hasVid: true), // redone
            Algorithm(name: "straggler 3", algorithm: "R U' R' U' R' U R2 U' R'", note: "", hasVid: true), // redone
            Algorithm(name: "straggler 4", algorithm: "y L' U L U L U' L2' U L", note: "", hasVid: true), // redone
            Algorithm(name: "straggler 5", algorithm: "L' U' L y L' U' L U L' U' L", note: "", hasVid: true),
            Algorithm(name: "straggler 6", algorithm: "y L' U' L U L' U L U' L U L'", note: "", hasVid: true),
            Algorithm(name: "straggler 7", algorithm: "L' U' R U R' L", note: "", hasVid: true),
            Algorithm(name: "straggler 8", algorithm: "R U L' U' L R'", note: "", hasVid: true),
            Algorithm(name: "straggler 9", algorithm: "R U' R2' U' R2 U2' R'", note: "", hasVid: true),
            Algorithm(name: "straggler 10", algorithm: "y L' U L2 U L2' U2 L", note: "", hasVid: true)
        ]),
        Category(name: "Opposite corners", algorithms: [
            Algorithm(name: "opposite 1", algorithm: "y R' U' R y' R U' R' y U' L' U L", note: "oriented edge", hasVid: true),
            Algorithm(name: "opposite 2", algorithm: "L U L' U' R U' R' y U' L' U L", note: "edge opposite", hasVid: true),
            Algorithm(name: "opposite 3", algorithm: "L U2 L' R U' R' U R U' R'", note: "oriented edge", hasVid: true),
            Algorithm(name: "opposite 4", algorithm: "y R' U R y' R U' R' U R U' R'", note: "edge opposite", hasVid: true),
            Algorithm(name: "opposite 5", algorithm: "y R' U2' R L' U L U' L' U L", note: "oriented edge", hasVid: true),
            Algorithm(name: "opposite 6", algorithm: "L U' L' y L' U L U' L' U L", note: "edge opposite", hasVid: true),
            Algorithm(name: "opposite 7", algorithm: "R U R' y2' R U' R' U' R U2' R'", note: "oriented edge", hasVid: true),
            Algorithm(name: "opposite 8", algorithm: "R U R' L U L' d L' U' L", note: "edge opposite", hasVid: true),
            Algorithm(name: "opposite 9", algorithm: "y L' U' L R' U2' R U' R' U' R", note: "oriented edge", hasVid: true),
            Algorithm(name: "opposite 10", algorithm: "R U2' R' y' L' U L d' L U' L'", note: "edge opposite", hasVid: true),
            Algorithm(name: "opposite 11", algorithm: "R U R' L U2 L' U L U L'", note: "oriented edge", hasVid: true),
            Algorithm(name: "opposite 12", algorithm: "y L' U2 L y R U' R' d R' U R", note: "edge opposite", hasVid: true),
            Algorithm(name: "opposite 13", algorithm: "R U' R' d' R' U2' R U R' U2' R", note: "", hasVid: true),
            Algorithm(name: "opposite 14", algorithm: "y L' U L U' L' U2 L R' U2' R", note: "", hasVid: true),
            Algorithm(name: "opposite 15", algorithm: "R U' R' U' R U' R' d' R' U' R", note: "", hasVid: true),
            Algorithm(name: "opposite 16", algorithm: "R U' R' U R U2' R' L U2 L'", note: "", hasVid: true),
            Algorithm(name: "opposite 17", algorithm: "y L' U L U L' U L d L U L'", note: "", hasVid: true)
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
                Text("Advanced F2L")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                Spacer()
                ScrollView(showsIndicators: false) {
                    VStack {
                        NavigationLink(destination: AllAlgorithmsView(categories: categories)) {
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
                                    showIndividualView = false
                                    selectedCategoryForList = category
                                    showListView = true
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
            }
            .padding()
            SolveCountButton(model: solveCountModel, editCount: $editCount)
                .padding(.top, 15)
        }
        .navigationDestination(isPresented: $showIndividualView) {
            IndividualCategoryView(category: selectedCategoryForIndividual ?? categories.first!)
        }
        .navigationDestination(isPresented: $showListView) {
            ListView(category: selectedCategoryForList ?? categories.first!)
        }
    }
}

#Preview {
    AdvancedF2LView()
}
