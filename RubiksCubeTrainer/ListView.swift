//
//  ListView.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 2025-03-28.
//

import SwiftUI

struct ListView: View {
    var category: Category
    @State private var algorithms: [Algorithm]
    @State private var needsWorkArray: [Algorithm]
    
    init(category: Category) {
        self.category = category
        _algorithms = State(initialValue: category.algorithms)
        if let data = UserDefaults.standard.data(forKey: "needsWork"),
           let decoded = try? JSONDecoder().decode([Algorithm].self, from: data) {
            _needsWorkArray = State(initialValue: decoded)
        } else {
            _needsWorkArray = State(initialValue: [])
        }
    }
    
    @EnvironmentObject var solveCountModel: SolveCountModel
    @State var editCount = false
    @State var mirroring = false
    
    var body: some View {
        ZStack {
            ScrollView {
                ForEach(Array(algorithms.enumerated()), id: \.element.id) { index, algorithm in
                    VStack(spacing: 0) {
                        AlgorithmRow(algorithm: algorithm, needsWorkArray: $needsWorkArray)
                            .listRowBackground(Color.yellow)
                        if index < algorithms.count - 1 {
                            Divider()
                        }
                    }
                }
            }
            .background(Color.yellow) // Set entire view background to yellow
            .scrollContentBackground(.hidden) // Hide default background
            .navigationTitle(category.name)
            SolveCountButton(editCount: $editCount)
        }
        .background(Color.yellow) // Set entire view background to yellow
    }
    
}
// MARK: - AlgorithmRow
struct AlgorithmRow: View {
    var algorithm: Algorithm
    @State private var localMirroring = false
    @State private var localRotating = false
    @Binding var needsWorkArray: [Algorithm]
        
    var body: some View {
        VStack {
            HStack {
                Text(algorithm.name)
                Button {
                    if !needsWorkArray.contains(where: { $0.name == algorithm.name }) {
                        print("adding \(algorithm.name) to needsWorkArray...")
                        needsWorkArray.append(algorithm)
                        if let encoded = try? JSONEncoder().encode(needsWorkArray) {
                            UserDefaults.standard.set(encoded, forKey: "needsWork")
                        }
                        print("needsWork array count: \(needsWorkArray.count)")
                    }
                } label: {
                    Image(systemName: "figure.strengthtraining.traditional")
                        .foregroundStyle(needsWorkArray.contains(where: { $0.name == algorithm.name }) ? Color.gray : Color.blue)
                        .font(.system(size: 25))
                }
            }
            .offset(x: 25) // offset by the size of the button to keep it center!
            if algorithm.roofpig {
                if localMirroring && localRotating {
                    RoofPigView(
                        algorithm: algorithmStripper(alg: algMirrorerWithParens(alg: algRotator(alg: algorithm.algorithm))),
                        setup: setupMirrorer(setup: algorithm.setupMoves),
                        type: algorithm.type,
                        mirrored: localMirroring, rotated: localRotating)
                    .frame(width: 350, height: 410)
                    .id(localMirroring)
                } else if localMirroring {
                    RoofPigView(
                        algorithm: algorithmStripper(alg: algMirrorerWithParens(alg: algorithm.algorithm)),
                        setup: setupMirrorer(setup: algorithm.setupMoves),
                        type: algorithm.type,
                        mirrored: localMirroring, rotated: localRotating)
                    .frame(width: 350, height: 410)
                    .id(localMirroring)
                } else if localRotating {
                    RoofPigView(
                        algorithm: algorithmStripper(alg: algRotator(alg: algorithm.algorithm)),
                        setup: algorithm.setupMoves,
                        type: algorithm.type,
                        mirrored: localMirroring, rotated: localRotating)
                    .frame(width: 350, height: 410)
                    .id(localMirroring)
                } else {
                    RoofPigView(algorithm: algorithmStripper(alg: algorithm.algorithm), setup: algorithm.setupMoves, type: algorithm.type, mirrored: localMirroring, rotated: localRotating)
                        .frame(width: 350, height: 410)
                        .id(localMirroring)
                }
            } else {
                Image(algorithm.name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 40)
            }
            if algorithm.note != "" {
                Text("(\(algorithm.note))")
                    .padding(.bottom, 10)
            }
            if localMirroring && localRotating {
                Text(algMirrorerWithParens(alg: algRotator(alg: algorithm.algorithm)))
                    .font(.title)
            } else if localMirroring {
                Text(algMirrorerWithParens(alg: algorithm.algorithm))
                    .font(.title)
            } else if localRotating {
                Text(algRotator(alg: algorithm.algorithm))
                    .font(.title)
            } else {
                Text(algorithm.algorithm)
                    .font(.title)
                    .padding(.bottom, 10)
            }
            if algorithm.roofpig {
                HStack {
                    Button {
                        localMirroring.toggle()
                        print("localMirroring: \(localMirroring), localRotating: \(localRotating)")
                    } label: {
                        Image(systemName: "arrow.left.and.right.circle.fill")
                            .padding(.bottom, 10)
                            .font(.system(size: 40))
                            .foregroundStyle(Color.indigo)
                    }
                    .allowsHitTesting(true)
                    Button {
                        localRotating.toggle()
                        print("localMirroring: \(localMirroring), localRotating: \(localRotating)")
                    } label: {
                        Image(systemName: "arrow.up.and.down.circle.fill")
                            .padding(.bottom, 10)
                            .font(.system(size: 40))
                            .foregroundStyle(Color.indigo)
                    }
                }
            }
        }
    }
}

//#Preview {
//    ListView()
//}
