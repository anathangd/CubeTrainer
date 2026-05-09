//
//  SimpleOLL.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 2025-03-20.
//

import SwiftUI

struct IndividualCategoryView: View {
    var category: Category
    @State private var algorithms: [Algorithm]
    // Store current index of the displayed algorithm
    @State private var currentIndex = 0
    @State var showAll = false
    @State private var showAnswerImage = false
    @State private var playTrigger = true
    @State private var count = 0
    @State private var needsWorkArray: [Algorithm] = []
    @State private var mirroring: Bool = false
    @State private var rotating: Bool = false
    @State private var imageVariant: Int = Int.random(in: 1...4)
    private let eightVariantImages: Set<String> = [
        "3colorcheckermiddle",
        "noblocksnochecker",
        "oneblockinside",
        "oneblockoutside"
    ]
    
    init(category: Category) {
        self.category = category
        _algorithms = State(initialValue: category.algorithms)
        if let data = UserDefaults.standard.data(forKey: "needsWork"),
           let decoded = try? JSONDecoder().decode([Algorithm].self, from: data) {
            _needsWorkArray = State(initialValue: decoded)
        }
    }
    
    @State private var initialized = false

    private var usesPLLRecVariants: Bool {
        category.name == "PLL Rec Abridged"
    }

    private var isContinuousF2L: Bool {
        category.name == "Continuous F2L"
    }

    private var continuousF2LIndexKey: String {
        "ContinuousF2LCurrentIndex"
    }

    private var currentImageName: String {
        guard !algorithms.isEmpty else {
            return "Loading..."
        }

        let baseName = algorithms[currentIndex].name

        guard usesPLLRecVariants, !baseName.isEmpty else {
            return baseName
        }

        var name = baseName
        name.removeLast()
        let fullName = name + String(imageVariant)
        print("Current image variant selected:", fullName)
        return fullName
    }

    var body: some View {
        GeometryReader { geo in
            let roofpigWidth = geo.size.width * 0.95
            let roofpigAspectRatio: CGFloat = 0.9 // width / height — adjust this while experimenting
            let roofpigHeight = roofpigWidth / roofpigAspectRatio
            
            ZStack {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundStyle(.yellow)
                    .onTapGesture {
                        showAll = true
                    }
                VStack {
                    // Display algorithm name and steps
                    if !algorithms.isEmpty {
                        if (category.name == "Continuous F2L") {
                            Text("\(currentIndex + 1) / \(algorithms.count)")
                        } else {
                            Text("Algorithms left: \(algorithms.count)")
                        }
                        
                        Text(currentImageName)
                            .padding(.top, 10)
                        
                        if initialized && algorithms[currentIndex].roofpig {
                            if mirroring && rotating {
                                RoofPigView(algorithm: algorithmStripper(alg: algMirrorerWithParens(alg: algRotator(alg: algorithms[currentIndex].algorithm))), setup: setupMirrorer(setup: algorithms[currentIndex].setupMoves), type: algorithms[currentIndex].type, mirrored: mirroring, rotated: rotating)
                                    .frame(width: roofpigWidth, height: roofpigHeight)
                                    .id("\(mirroring)-\(currentIndex)-\(count)")
                            } else if mirroring {
                                RoofPigView(algorithm: algorithmStripper(alg: algMirrorerWithParens(alg: algorithms[currentIndex].algorithm)), setup: setupMirrorer(setup: algorithms[currentIndex].setupMoves), type: algorithms[currentIndex].type, mirrored: mirroring, rotated: rotating)
                                    .frame(width: roofpigWidth, height: roofpigHeight)
                                    .id("\(mirroring)-\(currentIndex)-\(count)")
                            } else if rotating {
                                RoofPigView(algorithm: algorithmStripper(alg: algRotator(alg: algorithms[currentIndex].algorithm)), setup: algorithms[currentIndex].setupMoves, type: algorithms[currentIndex].type, mirrored: mirroring, rotated: rotating)
                                    .frame(width: roofpigWidth, height: roofpigHeight)
                                    .id("\(mirroring)-\(currentIndex)-\(count)")
                            } else {
                                RoofPigView(algorithm: algorithmStripper(alg: algorithms[currentIndex].algorithm), setup: algorithms[currentIndex].setupMoves, type: algorithms[currentIndex].type, mirrored: mirroring, rotated: rotating)
                                    .frame(width: roofpigWidth, height: roofpigHeight)
                                    .id("\(mirroring)-\(currentIndex)-\(count)")
                            }
                        } else {
                            Image(showAnswerImage ? algorithms[currentIndex].answer : currentImageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding((category.name.contains("Rec") && !showAnswerImage ? 0 : 40))
                                .onTapGesture {
                                    if algorithms[currentIndex].answer != "" {
                                        showAnswerImage.toggle()
                                    }
                                    showAll = true
                                }
                        }
                        
                        // algorithm note
                        if algorithms[currentIndex].note != "" {
                            Text("(\(algorithms[currentIndex].note))")
                                .font(.subheadline)
                        }
                        
                        // answer display
                        if showAll {
                            if mirroring && rotating {
                                Text(algMirrorerWithParens(alg: algRotator(alg: algorithms[currentIndex].algorithm)))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(category.name.contains("F2L") ? 1 : 2)
                                    .minimumScaleFactor(0.5)
                                    .font(.largeTitle)
                                    .padding()
                                    .onTapGesture { }
                            } else if rotating {
                                Text(algRotator(alg: algorithms[currentIndex].algorithm))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(category.name.contains("F2L") ? 1 : 2)
                                    .minimumScaleFactor(0.5)
                                    .font(.largeTitle)
                                    .padding()
                                    .onTapGesture { }
                            } else if mirroring {
                                Text(algMirrorerWithParens(alg: algorithms[currentIndex].algorithm))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(category.name.contains("F2L") ? 1 : 2)
                                    .minimumScaleFactor(0.5)
                                    .font(.largeTitle)
                                    .padding()
                                    .onTapGesture { }
                            } else {
                                Text(algorithms[currentIndex].algorithm)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(category.name.contains("F2L") ? 1 : 2)
                                    .minimumScaleFactor(0.5)
                                    .font(.largeTitle)
                                    .padding()
                                    .onTapGesture { }
                            }
                        }
                        Spacer()
                        // clear screen
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
                .padding(.top, -10)
                
                // buttons
                if !algorithms.isEmpty {
                    VStack {
                        Spacer()
                        // Mirror button
                        if algorithms[currentIndex].roofpig {
                            HStack {
                                Button {
                                    mirroring.toggle()
                                } label: {
                                    Image(systemName: "arrow.left.and.right.circle.fill")
                                        .font(.system(size: 40))
                                        .foregroundStyle(Color.indigo)
                                }
                                Button {
                                    rotating.toggle()
                                } label: {
                                    Image(systemName: "arrow.up.and.down.circle.fill")
                                        .font(.system(size: 40))
                                        .foregroundStyle(Color.indigo)
                                }
                            }
                        }
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
            .frame(maxWidth: .infinity, alignment: .center)
            .onTapGesture {
                showAll = true
            }
            .background(.yellow)
            .onAppear {
                for i in algorithms.indices {
                    algorithms[i].seen = false
                }
                
                if isContinuousF2L {
                    let savedIndex = UserDefaults.standard.integer(forKey: continuousF2LIndexKey)
                    if algorithms.indices.contains(savedIndex) {
                        currentIndex = savedIndex
                    } else {
                        currentIndex = 0
                        UserDefaults.standard.set(0, forKey: continuousF2LIndexKey)
                    }
                } else {
                    algorithms.shuffle()
                    currentIndex = 0
                }
                
                refreshImageVariant()
                DispatchQueue.main.async {
                    initialized = true
                }
            }
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
        showAnswerImage = false
        mirroring = false
        rotating = false
        count += 1

        if isContinuousF2L {
            if algorithms.indices.contains(currentIndex + 1) {
                currentIndex += 1
                UserDefaults.standard.set(currentIndex, forKey: continuousF2LIndexKey)
            } else {
                algorithms.removeAll()
                UserDefaults.standard.set(0, forKey: continuousF2LIndexKey)
            }
        } else {
            algorithms.remove(at: 0)
            currentIndex = 0
        }

        refreshImageVariant()
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
        showAnswerImage = false
        mirroring = false
        rotating = false
        count += 1

        if isContinuousF2L {
            if algorithms.indices.contains(currentIndex + 1) {
                currentIndex += 1
                UserDefaults.standard.set(currentIndex, forKey: continuousF2LIndexKey)
            } else {
                algorithms.removeAll()
                UserDefaults.standard.set(0, forKey: continuousF2LIndexKey)
            }
        } else {
            let current = algorithms[currentIndex]
            algorithms.remove(at: 0)
            algorithms.append(current)
            currentIndex = 0
        }

        refreshImageVariant()
    }

    private func refreshImageVariant() {

        guard usesPLLRecVariants else {
            return
        }

        guard !algorithms.isEmpty else {
            return
        }

        let baseName = algorithms[currentIndex].name
        var name = baseName
        name.removeLast()

        if eightVariantImages.contains(name) {
            imageVariant = Int.random(in: 1...8)
        } else {
            imageVariant = Int.random(in: 1...4)
        }
    }
    
    private func saveNeedsWork() {
        if let encoded = try? JSONEncoder().encode(needsWorkArray) {
            UserDefaults.standard.set(encoded, forKey: "needsWork")
        }
    }
}

#Preview {
    IndividualCategoryView(category: Category(name: "F2L", algorithms: [
        Algorithm(name: "corner edge top 1", algorithm: "(U' R U' R') (U R U R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 2", algorithm: "d (R' U R) (U' R' U' R)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 3", algorithm: "(U' R U R') (U R U R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 4", algorithm: "(U' R U' R') U (b' R' b)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 5", algorithm: "d (R' U2' R U') (f R f')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 6", algorithm: "(U' R U2' R') U (b' R' b)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 7", algorithm: "(R U' R') U2 (b' R' b)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 8", algorithm: "(R U R' U2') (R U' R' U R U' R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 9", algorithm: "d (R' U2' R U R' U2' R)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 10", algorithm: "(R U R') U (R U' R' U R U' R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 11", algorithm: "d (R' U' R U R' U2' R)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 12", algorithm: "(U' R U R') (U' R U2' R')", note: "", hasVid: true, roofpig: true),
    ]))
}
