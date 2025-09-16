//
//  SimpleOLL.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 2025-03-20.
//

import SwiftUI
import AVKit

struct IndividualCategoryView: View {
    var category: Category
    @State private var algorithms: [Algorithm]
    // Store current index of the displayed algorithm
    @State private var currentIndex = 0
    @State var showAll = false
    @State private var showVideo = false
    @State private var playTrigger = true
    @State private var count = 0
    @State private var needsWorkArray: [Algorithm] = []
    
    init(category: Category) {
        self.category = category
        _algorithms = State(initialValue: category.algorithms)
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
                if !algorithms.isEmpty {
                    Text("Algorithms left: \(algorithms.count)")
                    
                    Text(algorithms[currentIndex].name)
                        .padding(.top, 10)
                    
                    if showVideo {
                        F2LVideoView(videoName: algorithms[currentIndex].name, videoType: "mov", playTrigger: $playTrigger)
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
                        Image(algorithms[currentIndex].name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                if algorithms[currentIndex].hasVid {
                                    showVideo = true       
                                }
                                showAll = true
                            }
                    }
                    
                    if algorithms[currentIndex].note != "" {
                        Text("(\(algorithms[currentIndex].note))")
                            .font(.subheadline)
                    }
                        
                    
                    if showAll {
                        Text(algorithms[currentIndex].algorithm)
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
            .frame(maxWidth: .infinity, alignment: .center)
            .navigationTitle(category.name)
            .padding()
            
            if !algorithms.isEmpty {
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
        .frame(maxWidth: .infinity, alignment: .center)
        .onTapGesture {
            showAll = true
        }
        .background(.yellow)
        .onAppear {
            for i in algorithms.indices {
                algorithms[i].seen = false
            }
            algorithms.shuffle()
        }
    }
    
    private func markCorrect() {
        // if I haven't seen it, take it out of the needsWorkArray
        if !algorithms[currentIndex].seen {
            print("\(algorithms[currentIndex].name)")
            if let index = needsWorkArray.firstIndex(where: { $0.name == algorithms[currentIndex].name }) {
                print("removing \(algorithms[currentIndex].name) from needsWorkArray...")
                needsWorkArray.remove(at: index)
                saveNeedsWork()
                print("needsWork array count: \(needsWorkArray.count)")
            }
        }
        showAll = false
        count += 1
        algorithms.remove(at: 0)
    }
    
    private func markIncorrect() {
        if !algorithms[currentIndex].seen {
            algorithms[currentIndex].seen = true
            // Only append if it's not already in needsWorkArray
            if !needsWorkArray.contains(where: { $0.name == algorithms[currentIndex].name }) {
                print("adding \(algorithms[currentIndex].name) to needsWorkArray...")
                needsWorkArray.append(algorithms[currentIndex])
                saveNeedsWork()
                print("needsWork array count: \(needsWorkArray.count)")
            }
        }
        showAll = false
        count += 1
        let current = algorithms[currentIndex]
        algorithms.remove(at: 0)
        algorithms.append(current)
    }
    
    private func saveNeedsWork() {
        if let encoded = try? JSONEncoder().encode(needsWorkArray) {
            UserDefaults.standard.set(encoded, forKey: "needsWork")
        }
    }
}

#Preview {
    IndividualCategoryView(category: Category(name: "Simple OLL", algorithms: [
        Algorithm(name: "corner top edge middle 1", algorithm: "(U F' U F) (U F' U2 F)", note: "", hasVid: true),
        Algorithm(name: "corner top edge middle 2", algorithm: "(U' R U' R') (U' R U2 R')", note: "", hasVid: true),
        Algorithm(name: "corner top edge middle 3", algorithm: "(U F' U' F) (U' R U R')", note: "", hasVid: true),
        Algorithm(name: "corner top edge middle 4", algorithm: "(U' R U R') (d R' U' R)", note: "", hasVid: true),
        Algorithm(name: "corner top edge middle 5", algorithm: "(R U' R') (d R' U R)", note: "", hasVid: true),
        Algorithm(name: "corner bottom edge top 6", algorithm: "(F' U' F) (U F' U' F)", note: "", hasVid: true),
        Algorithm(name: "corner bottom edge middle 1", algorithm: "(R U' R' U) R U2 R' (U R U' R')", note: "", hasVid: true),
        Algorithm(name: "corner bottom edge middle 2", algorithm: "(R U' R' U') (R U R' U') (R U2 R')", note: "", hasVid: true),
        Algorithm(name: "corner bottom edge middle 3", algorithm: "(R U R' U') (R U' R') U d (R' U' R)", note: "", hasVid: true),
    ]))
}
