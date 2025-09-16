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
    @State private var showVideo = false
    @State private var playTrigger = true
    @State private var count = 0
    @State private var needsWorkArray: [Algorithm] = []
    
    init(categories: [Category]) {
        self.categories = categories
        _allAlgorithms = State(initialValue: categories.flatMap { $0.algorithms })
        if let data = UserDefaults.standard.data(forKey: "needsWork"),
           let decoded = try? JSONDecoder().decode([Algorithm].self, from: data) {
            _needsWorkArray = State(initialValue: decoded)
        }
    }

    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.yellow)
                .onTapGesture {
                    showAll = true
                    if showVideo {
                        showVideo = false
                    }
                }
            VStack {
                // Display algorithm name and steps
                if !allAlgorithms.isEmpty {
                    Text("Algorithms left: \(allAlgorithms.count)")
                    
                    Text(allAlgorithms[currentIndex].name)
                        .padding(.top, 10)
                    
                    if showVideo {
                        F2LVideoView(videoName: allAlgorithms[currentIndex].name, videoType: "mov", playTrigger: $playTrigger)
                            .frame(width: 450, height: 450)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                            .onTapGesture {
                                playTrigger = true
                            }
                            .onAppear {
                                // Trigger playback on first load
                                playTrigger = true
                            }
                    } else {
                        Image(allAlgorithms[currentIndex].name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                if allAlgorithms[currentIndex].hasVid {
                                    showVideo = true
                                }
                                showAll = true
                            }
                    }
                    
                    if allAlgorithms[currentIndex].note != "" {
                        Text("(\(allAlgorithms[currentIndex].note))")
                            .font(.subheadline)
                    }
                    
                    if showAll {
                        Text(allAlgorithms[currentIndex].algorithm)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)
                            .font(.largeTitle)
                            .padding()
                            .onTapGesture {
                                if showVideo {
                                    showVideo = false
                                }
                            }
                    }
                    
                    Spacer()
                } else {
                    ZStack {
                        Rectangle()
                            .ignoresSafeArea()
                            .foregroundStyle(.yellow)
                        VStack {
                            Text("You did it! 🎉")
                            Text("You cycled through the stack \(count) times!")
                        }
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
                            showVideo = false
                            markCorrect()
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 50))
                                .foregroundStyle(Color.green)
                                .background(.blue, in: Circle())
                                .padding(20)
                        }
                        Button { //wrong
                            showVideo = false
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
            for i in allAlgorithms.indices {
                allAlgorithms[i].seen = false
            }
            allAlgorithms.shuffle()
        }
    }
    
    private func markCorrect() {
        // if I haven't seen it, take it out of the needsWorkArray
        if !allAlgorithms[currentIndex].seen {
            if let index = needsWorkArray.firstIndex(where: { $0.name == allAlgorithms[currentIndex].name }) {
                print("removing \(allAlgorithms[currentIndex].name) from needsWorkArray...")
                needsWorkArray.remove(at: index)
                saveNeedsWork()
                print("needsWork array count: \(needsWorkArray.count)")
            }
        }
        showAll = false
        count += 1
        allAlgorithms.remove(at: 0)
    }
    
    private func markIncorrect() {
        if !allAlgorithms[currentIndex].seen {
            allAlgorithms[currentIndex].seen = true
            // Only append if it's not already in needsWorkArray
            if !needsWorkArray.contains(where: { $0.name == allAlgorithms[currentIndex].name }) {
                print("adding \(allAlgorithms[currentIndex].name) to needsWorkArray...")
                needsWorkArray.append(allAlgorithms[currentIndex])
                saveNeedsWork()
                print("needsWork array count: \(needsWorkArray.count)")
            }
        }
        showAll = false
        count += 1
        let current = allAlgorithms[currentIndex]
        allAlgorithms.remove(at: 0)
        allAlgorithms.append(current)
    }
    
    private func saveNeedsWork() {
        if let encoded = try? JSONEncoder().encode(needsWorkArray) {
            UserDefaults.standard.set(encoded, forKey: "needsWork")
        }
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
