//
//  AllAlgorithmsView.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 2025-03-20.
//

import SwiftUI

struct AllAlgorithmsView: View {
    var categories: [Category]
    @State private var allAlgorithms: [Algorithm]
    
    // Store current index of the displayed algorithm
    @State private var currentIndex = 0
    @State var showAll = false
    
    init(categories: [Category]) {
        self.categories = categories
        _allAlgorithms = State(initialValue: categories.flatMap { $0.algorithms })
    }

    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.yellow)
                .onTapGesture {
                    showAll = true
                }
            VStack {
                // Display algorithm name and steps
                if !allAlgorithms.isEmpty {
                    Text("Algorithms left: \(allAlgorithms.count)")
                    
                    Text(allAlgorithms[currentIndex].name)
                        .padding(.top, 10)
                    
                    Image(allAlgorithms[currentIndex].name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Text("(\(allAlgorithms[currentIndex].note))")
                        .font(.subheadline)
                        .padding()
                    
                    if showAll {
                        Text(allAlgorithms[currentIndex].algorithm)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)
                            .font(.largeTitle)
                            .padding()
                    }
                    
                    Spacer()
                } else {
                    ZStack {
                        Rectangle()
                            .ignoresSafeArea()
                            .foregroundStyle(.yellow)
                        Text("You did it! 🎉")
                    }
                }
            }
            .navigationTitle("All Algorithms")
            .padding()
            
            if !allAlgorithms.isEmpty {
                VStack {
                    Spacer()
                    HStack {
                        Button { //right
                            markCorrect()
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 50))
                                .foregroundStyle(Color.green)
                                .background(.blue, in: Circle())
                                .padding(20)
                        }
                        Button { //wrong
                            markIncorrect()
                        } label: {
                            Image(systemName: "x.circle")
                                .font(.system(size: 50))
                                .foregroundStyle(Color.orange)
                                .background(.red, in: Circle())
                                .padding(20)
                        }
                    } // correct and incorrect buttons
                }
            }
        }
        .background(.yellow)
        .onAppear {
            allAlgorithms.shuffle()
        }
    }
    
    private func markCorrect() {
        showAll = false
        allAlgorithms.remove(at: 0)
    }
    
    private func markIncorrect() {
        showAll = false
        let current = allAlgorithms[currentIndex]
        allAlgorithms.remove(at: 0)
        allAlgorithms.append(current)
    }
}

#Preview {
    AllAlgorithmsView(categories: [
        Category(name: "Simple OLL", algorithms: [
            Algorithm(name: "Lshape", algorithm: "F U R U' R' F'", note: "6 times"),
            Algorithm(name: "line", algorithm: "F R U R' U' F'", note: "6 times"),
            Algorithm(name: "dot", algorithm: "gR U2 (R2' gF R F') U2 (R' F R F')", note: "18 times"),
            Algorithm(name: "fishRight", algorithm: "(L' U2 L) U (L' U L)", note: "6 times"),
            Algorithm(name: "fishLeft", algorithm: "(R U2 R') U' (R U' R')", note: "6 times"),
            Algorithm(name: "diagonalLeft", algorithm: "F' (r U R' U') (gr' F R)", note: "3 times"),
            Algorithm(name: "Tout90", algorithm: "(gr U R' U') (gr' F R F')", note: "3 times"),
            Algorithm(name: "crossMan90", algorithm: "R U2 (R2' U' R2 U') (R2' U2 R)", note: "6 times"),
            Algorithm(name: "cross", algorithm: "(gR U R') gU (R U' R') U (R U2 R')", note: "3 times"),
            Algorithm(name: "T", algorithm: "R2 D (R' U2 R) D' (R' U2 R')", note: "3 times")
        ]),
        Category(name: "Simple PLL", algorithms: [
            Algorithm(name: "headlights", algorithm: "x (R2 D2) (R U R') D2 (R U' R)", note: "3 times"),
            Algorithm(name: "noHL", algorithm: "F R U' R' U' R U R' F' (R U R' U') (gR' F R F')", note: "2 times"),
            Algorithm(name: "cwEdges", algorithm: "M2 U' M U2 M' U' M2", note: "3 times"),
            Algorithm(name: "ccwEdges", algorithm: "M2 U M U2 M' U M2", note: "3 times"),
            Algorithm(name: "swap180", algorithm: "(M2 U' M2) U2 (M2 U' M2)", note: "2 times"),
            Algorithm(name: "swapAdj", algorithm: "M' U' M2 U' M2 U' M' U2 M2 U", note: "2 times")
        ])
    ])
}
