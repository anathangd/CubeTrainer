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
    
    init(category: Category) {
        self.category = category
        _algorithms = State(initialValue: category.algorithms)
    }
    
    @EnvironmentObject var solveCountModel: SolveCountModel
    @State var editCount = false
    @State var mirroring = false
    
    var body: some View {
        ZStack {
            ScrollView {
                ForEach(algorithms) { algorithm in
                    AlgorithmRow(algorithm: algorithm)
                        .listRowBackground(Color.yellow)
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
    var body: some View {
        VStack {
            Text(algorithm.name)
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
            }
            if algorithm.roofpig {
                HStack {
                    Button {
                        localMirroring.toggle()
                        print("localMirroring: \(localMirroring), localRotating: \(localRotating)")
                    } label: {
                        Image(systemName: "arrow.left.and.right.circle.fill")
                            .padding(.top, 10)
                            .font(.system(size: 40))
                            .foregroundStyle(Color.indigo)                    
                    }
                    .allowsHitTesting(true)
                    Button {
                        localRotating.toggle()
                        print("localMirroring: \(localMirroring), localRotating: \(localRotating)")
                    } label: {
                        Image(systemName: "arrow.up.and.down.circle.fill")
                            .padding(.top, 10)
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
