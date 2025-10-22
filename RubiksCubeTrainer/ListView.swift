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
            List(algorithms) { algorithm in
                AlgorithmRow(algorithm: algorithm)
                    .listRowBackground(Color.yellow)
            }
            .scrollContentBackground(.hidden) // Hide default background
            .background(Color.yellow) // Set entire view background to yellow
            .navigationTitle(category.name)
            SolveCountButton(editCount: $editCount)
        }
    }
    
}
// MARK: - AlgorithmRow
struct AlgorithmRow: View {
    var algorithm: Algorithm
    @State private var localMirroring = false
    var body: some View {
        VStack {
            Text(algorithm.name)
            if algorithm.roofpig {
                RoofPigView(
                    algorithm: localMirroring ? algorithmStripper(alg: algMirrorerWithParens(alg: algorithm.algorithm)) : algorithmStripper(alg: algorithm.algorithm),
                    setup: localMirroring ? setupMirrorer(setup: algorithm.setupMoves) : algorithm.setupMoves,
                    type: algorithm.type,
                    mirrored: localMirroring
                )
                .frame(width: 350, height: 410)
                .id(localMirroring)
            } else {
                Image(algorithm.name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            if algorithm.note != "" {
                Text("(\(algorithm.note))")
                    .padding(.bottom, 10)
            }
            Text(localMirroring ? algMirrorerWithParens(alg: algorithm.algorithm) : algorithm.algorithm)
                .font(.title)
            if algorithm.roofpig {
                Button {
                    localMirroring.toggle()
                } label: {
                    Image(systemName: "arrow.left.and.right.circle.fill")
                        .padding(.top, 10)
                        .font(.system(size: 40))
                        .foregroundStyle(Color.indigo)                    
                }
            }
        }
    }
}

//#Preview {
//    ListView()
//}
