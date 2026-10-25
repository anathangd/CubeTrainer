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
    let categories: [Category] = AdvancedF2LAlgorithms.categories
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
            .ignoresSafeArea()
            SolveCountButton(editCount: $editCount)
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
