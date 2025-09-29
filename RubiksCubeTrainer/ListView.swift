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
    
    var body: some View {
        ZStack{
            List(algorithms) { algorithm in
                VStack {
                    Text(algorithm.name)
                    Image(algorithm.name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    if algorithm.note != "" {
                        Text("(\(algorithm.note))")
                            .padding(.bottom, 10)
                    }
                    Text(algorithm.algorithm)
                        .font(.title)
                }
                .listRowBackground(Color.yellow)
            }
            .scrollContentBackground(.hidden) // Hide default background
            .background(Color.yellow) // Set entire view background to yellow
            .navigationTitle(category.name)
            SolveCountButton(editCount: $editCount)
        }
    }
}

//#Preview {
//    ListView()
//}
