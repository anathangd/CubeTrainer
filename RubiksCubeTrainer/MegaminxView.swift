//
//  MegaminxView.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 7/12/25.
//

import SwiftUI

struct MegaminxView: View {
    let categories: [Category] = [
        Category(name: "Megaminx OLL", algorithms: [
            Algorithm(name: "orient edges 1", algorithm: "F R U2 (R2' F R F') U2' F'", note: "18 times"),
            Algorithm(name: "orient edges 2", algorithm: "F (U R U' R') F'", note: "6 times"),
            Algorithm(name: "orient edges 3", algorithm: "F (R U R' U') F'", note: "6 times"),
            
            Algorithm(name: "orient corners 1", algorithm: "F (R U2 R' U' R U' R') F'", note: "6 times"),
            Algorithm(name: "orient corners 2", algorithm: "(R U R' U) (R U R' U2') (R U' R')", note: ""),
            Algorithm(name: "orient corners 3", algorithm: "(R U R' U') (R' F R U) (R U' R' F)", note: ""),
            Algorithm(name: "orient corners 4", algorithm: "(R U2 R') U (R U2 R')", note: ""),
            Algorithm(name: "orient corners 5", algorithm: "R' U' R U' R' U2 R", note: ""),
            Algorithm(name: "orient corners 6", algorithm: "R U R' U R U2' R'", note: ""),
            Algorithm(name: "orient corners 7", algorithm: "R U R' U2 R U2 R'", note: ""),
            Algorithm(name: "orient corners 8", algorithm: "R U2 R' U' R U' R'", note: ""),
            Algorithm(name: "orient corners 9", algorithm: "(R U R' U) (R U' R' U) (R U2' R')", note: ""),
            Algorithm(name: "orient corners 10", algorithm: "(R U2 R' U') (R U R' U') (R U' R')", note: ""),
            Algorithm(name: "orient corners 11", algorithm: "(R U2 R' U' R U' R2')\n(U' R U' R' U2 R)", note: ""),
            Algorithm(name: "orient corners 12", algorithm: "(R U R' U) (R U R' U') (R U2' R')", note: ""),
            Algorithm(name: "orient corners 13", algorithm: "R U2 R2' U' R2\nU' R2' U2 R", note: ""),
            Algorithm(name: "orient corners 14", algorithm: "(R U R' U2) (R U2' R')\n(U R U2' R')", note: ""),
            Algorithm(name: "orient corners 15", algorithm: "R' U2' R2 U R2'\nU R2 U2' R'", note: ""),
            Algorithm(name: "orient corners 16", algorithm: "(R U2 R' U') (R U2 R' U2)\n(R U' R')", note: ""),
        ]),
        Category(name: "Megaminx PLL", algorithms: [
            Algorithm(name: "rotate edges 1", algorithm: "(R U R' U) (R' U' R2 U')\n(R' U R' U) R U2'", note: "3 times"), //verified
            Algorithm(name: "rotate edges 2", algorithm: "(R U R' F') (R U R' U')\n(R' F R2 U' R')", note: "3 times"), //verified
            Algorithm(name: "rotate edges 3", algorithm: "(L R U2) (L' U R')\n(L U' R U2) (L' U2 R')", note: "2 times"), //verified
            Algorithm(name: "rotate edges 4", algorithm: "R2 U2' R2' U' R2 U2' R2'", note: "15 times"), //verified
            Algorithm(name: "rotate edges 5", algorithm: "R2 U2 R2' U R2 U2 R2'", note: "15 times"), //verified
            
            Algorithm(name: "position corners 1", algorithm: "(R' F' BR' R) (BR R' F R)\n(BR' R' BR R)", note: ""),
            Algorithm(name: "position corners 2", algorithm: "(R' BR' R BR) (R' F' R BR')\n(R' BR F R)", note: ""),
            Algorithm(name: "position corners 3", algorithm: "y L' (R U2 R' U') (R U R' U')\n(R U R' U') R U' R' L", note: ""),
            Algorithm(name: "position corners 4", algorithm: "BR' R2' (U L U' R)\n(U L' U' R) BR", note: ""),
            Algorithm(name: "position corners 5", algorithm: "BR' (R' U L U') (R' U L' U') R2 BR", note: ""),
            Algorithm(name: "position corners 6", algorithm: "R2 U R' U' y (R U R' U') (R U R' U') (R U R') y' R U' R2'", note: ""),
            Algorithm(name: "position corners 7", algorithm: "(R U R' U) (R' U' R F') (R U R' U') (R' F R2 U')\n(R2' U R U')", note: ""),
            Algorithm(name: "position corners 8", algorithm: "[(R U R' U) (R' U' R2 U')\n(R' U R' U R) U] * 2", note: ""),
            Algorithm(name: "position corners 9", algorithm: "F (R U2 R' U' R U' R')\nF' R' y' (R' U' R U' R' U2 R BR) U'", note: "5 times"),
            Algorithm(name: "position corners 10", algorithm: "R2 U2 R2' U' R2 U'\nR2' y' R2' U' R2\nU' R2' U2 R2 U'", note: ""),
            Algorithm(name: "position corners 11", algorithm: "R2' U2' R2 U R2' U R2 y R2 U R2' U R2 U2' R2' U", note: ""),
            Algorithm(name: "position corners 12", algorithm: "R2 U2' R2' U R2 U2'\n(R' U R' U') (R' F R2 U')\n(R' U' R U) R' F'", note: ""),
            Algorithm(name: "position corners 13", algorithm: "(R' U2 R U') (R' U2 R U2') (R' U' R U2') (R' U R U2') (R' U R)", note: ""),
            Algorithm(name: "position corners 14", algorithm: "(R2 U2' R2' U') (R2 U\nR2' U') (R2 U R2' U') (R2 U2' R2')", note: ""),
            Algorithm(name: "position corners 15", algorithm: "(R2 U2 R2' U) (R2\nU' R2' U) (R2 U' R2' U)\n(R2 U2 R2')", note: ""),
        ])
    ]
    var allAlgorithmsCategory: Category {
        Category(
            name: "All Algorithms",
            algorithms: categories.flatMap { $0.algorithms }
        )
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.yellow)
                .ignoresSafeArea()
            VStack {
                Text("Megaminx!")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                Spacer()
                ScrollView(showsIndicators: false) {
                    NavigationLink(destination: IndividualCategoryView(category: allAlgorithmsCategory)) {
                        Text("All Algorithms")
                            .capsuleButtonStyle()
                    }
                    
                    NavigationLink(destination: IndividualCategoryView(category: categories.first { $0.name == "Megaminx OLL" }!)) {
                        Text("Megaminx OLL")
                            .capsuleButtonStyle()
                    }
                    
                    NavigationLink(destination: ListView(category: categories.first { $0.name == "Megaminx OLL" }!)) {
                        Text("Megaminx OLL List")
                            .capsuleButtonStyle()
                    }

                    NavigationLink(destination: IndividualCategoryView(category: categories.first { $0.name == "Megaminx PLL" }!)) {
                        Text("Megaminx PLL")
                            .capsuleButtonStyle()
                    }

                    NavigationLink(destination: ListView(category: categories.first { $0.name == "Megaminx PLL" }!)) {
                        Text("Megaminx PLL List")
                            .capsuleButtonStyle()
                    }
                    
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    MegaminxView()
}
