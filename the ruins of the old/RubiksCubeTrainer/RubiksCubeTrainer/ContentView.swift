//
//  ContentView.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 2025-03-20.
//

import SwiftUI

struct ContentView: View {
    let color = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    let categories: [Category] = [
            Category(name: "Simple OLL", algorithms: [
                Algorithm(name: "Lshape", algorithm: "F U R U' R' F'", note: "6 times"),
                Algorithm(name: "line", algorithm: "F R U R' U' F'", note: "6 times"),
                Algorithm(name: "dot", algorithm: "gR U2 (R2' gF R F') U2\n(R' F R F')", note: "18 times"),
                Algorithm(name: "fishRight", algorithm: "(L' U2 L) U (L' U L)", note: "6 times"),
                Algorithm(name: "fishLeft", algorithm: "(R U2 R') U' (R U' R')", note: "6 times"),
                Algorithm(name: "diagonalLeft", algorithm: "F' (r U R' U') (gr' F R)", note: "3 times"),
                Algorithm(name: "Tout90", algorithm: "(gr U R' U') (gr' F R F')", note: "3 times"),
                Algorithm(name: "crossMan90", algorithm: "R U2 (R2' U' R2 U')\n(R2' U2 R)", note: "6 times"),
                Algorithm(name: "cross", algorithm: "(gR U R') gU (R U' R') U\n(R U2 R')", note: "3 times"),
                Algorithm(name: "Tdown", algorithm: "R2 D (R' U2 R) D'\n(R' U2 R')", note: "3 times")
            ]),
            Category(name: "Simple PLL", algorithms: [
                Algorithm(name: "headlights", algorithm: "x (R2 D2) (R U R') D2\n(R U' R)", note: "3 times"),
                Algorithm(name: "noHL", algorithm: "F R U' R' U' R U R' F' (R U R' U') (gR' F R F')", note: "2 times"),
                Algorithm(name: "cwEdges", algorithm: "M2 U' M U2 M' U' M2", note: "3 times"),
                Algorithm(name: "ccwEdges", algorithm: "M2 U M U2 M' U M2", note: "3 times"),
                Algorithm(name: "swap180", algorithm: "(M2 U' M2) U2\n(M2 U' M2)", note: "2 times"),
                Algorithm(name: "swapAdj", algorithm: "M' U' M2 U' M2\nU' M' U2 M2 U", note: "2 times")
            ]),
            Category(name: "Full PLL", algorithms: [
                Algorithm(name: "F", algorithm: "U' (gR' U R U') R2 (F' U' F gU) x (gR U R' U') R2 x'", note: "2 times"),
                Algorithm(name: "Ga", algorithm: "y R2' u (gR' U R' U') (R u' R2) y' (gR' U R)", note: "3 times"),
                Algorithm(name: "Gb", algorithm: "(R' U' R) y R2 u (gR' U R U') (gR u' R2)", note: "4 times"),
                Algorithm(name: "Gc", algorithm: "y' L2 u' (gL U' L U) (L' u L2) y (gL U' L')", note: "3 times"),
                Algorithm(name: "Gd", algorithm: "(L U L') y' L2 u' (gL U' L' U) (gL' u L2)", note: "4 times"),
                Algorithm(name: "H", algorithm: "(M2 U' M2) U2\n(M2 U' M2)", note: "2 times"),
                Algorithm(name: "Z", algorithm: "M' U' M2 U' M2\nU' M' U2 M2 U", note: "2 times"),
                Algorithm(name: "Ua", algorithm: "M2 U M U2 M' U M2", note: "3 times"),
                Algorithm(name: "Ub", algorithm: "M2 U' M U2 M' U' M2", note: "3 times"),
                Algorithm(name: "Aa", algorithm: "x z' R2 U2 (R' D' R) U2 (R' D R') z x'", note: "3 times"),
                Algorithm(name: "Ab", algorithm: "x (R2 D2) (R U R') D2\n(R U' R) x'", note: "3 times"),
                Algorithm(name: "E", algorithm: "R2 U R' U' y (R U R' U') (R U R' U') (R U R') y' (R U' R2')", note: "2 times"),
                Algorithm(name: "Na", algorithm: "(gR U gR' U) (gR U R' F') (R U R' U') gR' F\nR2 U' R' U2 (R U' R')", note: "2 times"),
                Algorithm(name: "Nb", algorithm: "(gL' U' gL U') (gL' U' L F) (L' U' L U) gL F'\nL2 U L U2 (L' U L)", note: "2 times"),
                Algorithm(name: "T", algorithm: "(R U R' U') gR' F\nR2 U' R' U' gR U R' F'", note: "2 times"),
                Algorithm(name: "Y", algorithm: "(F R U' R') U' (R U R' F') (R U R' U') (gR' F R F')", note: "2 times"),
                Algorithm(name: "V", algorithm: "(R' U R' U') y (R' D gR' D') R2 y' (R' B' R B R)", note: "2 times"),
                Algorithm(name: "Ja", algorithm: "L' U' L F (L' U' L U) gL F' L2 U L U", note: "2 times"),
                Algorithm(name: "Jb", algorithm: "R U R' F' (R U R' U') gR' F R2 U' R' U'", note: "2 times"),
                Algorithm(name: "Ra", algorithm: "(L U2 L') U2 L F' (L' U' L U) gL F L2 U", note: "2 times"),
                Algorithm(name: "Rb", algorithm: "(R' U2 R) U2 R' F (R U R' U') gR' F' R2 U'", note: "2 times"),
            ]),
            
            Category(name: "F2L", algorithms: [
                Algorithm(name: "corner edge top 1", algorithm: "(U' R U') (R' U R) U R'", note: "", hasVid: true),
                Algorithm(name: "corner edge top 2", algorithm: "(d R' U) (R U' R') U' R", note: "", hasVid: true),
                Algorithm(name: "corner edge top 3", algorithm: "(U' R U) (R' U R) U R'", note: "", hasVid: true),
                Algorithm(name: "corner edge top 4", algorithm: "y (U L' U') (L U' L') U' L", note: "", hasVid: true),
                Algorithm(name: "corner edge top 5", algorithm: "y U (L' U2 L) d' (L U L')", note: "", hasVid: true),
                Algorithm(name: "corner edge top 6", algorithm: "U' (R U2 R') d (R' U' R)", note: "", hasVid: true),
                Algorithm(name: "corner edge top 7", algorithm: "(R U' R' U) d (R' U' R)", note: "", hasVid: true),
                Algorithm(name: "corner edge top 8", algorithm: "y (L' U L U') d' (L U L')", note: "", hasVid: true),
                Algorithm(name: "corner edge top 9", algorithm: "y (U L' U2 L) (U L' U2 L)", note: "", hasVid: true),
                Algorithm(name: "corner edge top 10", algorithm: "(U' R U2 R') (U' R U2 R')", note: "", hasVid: true),
                Algorithm(name: "corner edge top 11", algorithm: "y (U L' U' L) (U L' U2 L)", note: "", hasVid: true),
                Algorithm(name: "corner edge top 12", algorithm: "(U' R U R') (U' R U2 R')", note: "", hasVid: true),
                
                Algorithm(name: "corner up edge top 1", algorithm: "(R U2 R' U') (R U R')", note: "", hasVid: true),
                Algorithm(name: "corner up edge top 2", algorithm: "y (L' U2 L U) (L' U' L)", note: "", hasVid: true),
                Algorithm(name: "corner up edge top 3", algorithm: "(U R U2 R') (U R U' R')", note: "", hasVid: true),
                Algorithm(name: "corner up edge top 4", algorithm: "(U' F' U2 F) (U' F' U F)", note: "", hasVid: true),
                Algorithm(name: "corner up edge top 5", algorithm: "U2 (R U R' U) (R U' R')", note: "", hasVid: true),
                Algorithm(name: "corner up edge top 6", algorithm: "U2 (F' U' F U') (F' U F)", note: "", hasVid: true),
                Algorithm(name: "corner up edge top 7", algorithm: "(U R U' R') (U' R U' R') (U R U' R')", note: "", hasVid: true),
                Algorithm(name: "corner up edge top 8", algorithm: "y (U' L' U L) (U L' U L) (U' L' U L)", note: "", hasVid: true),
                
                Algorithm(name: "corner top edge middle 1", algorithm: "y (U L' U L) (U L' U2 L)", note: "", hasVid: true),
                Algorithm(name: "corner top edge middle 2", algorithm: "(U' R U' R') (U' R U2 R')", note: "", hasVid: true),
                Algorithm(name: "corner top edge middle 3", algorithm: "y (U L' U' L) (d' L U L')", note: "", hasVid: true),
                Algorithm(name: "corner top edge middle 4", algorithm: "(U' R U R') (d R' U' R)", note: "", hasVid: true),
                Algorithm(name: "corner top edge middle 5", algorithm: "(R U' R') (d R' U R)", note: "", hasVid: true),
                Algorithm(name: "corner top edge middle 6", algorithm: "(R U R' U') (R U R' U') (R U R')", note: "", hasVid: true),
                
                Algorithm(name: "corner bottom edge top 1", algorithm: "(U R U' R') (U' F' U F)", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge top 2", algorithm: "(U' F' U F) (U R U' R')", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge top 3", algorithm: "(F' U F) (U' F' U F)", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge top 4", algorithm: "(R U' R') (U R U' R')", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge top 5", algorithm: "(R U R') (U' R U R')", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge top 6", algorithm: "(F' U' F) (d R' U' R)", note: "", hasVid: true),
                
                Algorithm(name: "corner bottom edge middle 1", algorithm: "(R U' R' U) R U2 R' (U R U' R')", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge middle 2", algorithm: "(R U' R' U') (R U R' U') (R U2 R')", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge middle 3", algorithm: "(R U R' U') (R U' R') U d (R' U' R)", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge middle 4", algorithm: "(R U' R') d (R' U' R U') (R' U' R)", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge middle 5", algorithm: "(R U' R' d R' U2 R) (U R' U2 R)", note: "", hasVid: true),
            ]),
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
                Algorithm(name: "position corners 9", algorithm: "F (R U2 R' U' R U' R')\nF R' y' (R' U' R U' R' U2 R BR) U'", note: ""),
                Algorithm(name: "position corners 10", algorithm: "R2 U2 R2' U' R2 U'\nR2' y' R2' U' R2\nU' R2' U2 R2 U'", note: ""),
                Algorithm(name: "position corners 11", algorithm: "R2' U2' R2 U R2' U R2 y R2 U R2' U R2 U2' R2' U", note: ""),
                Algorithm(name: "position corners 12", algorithm: "R2 U2' R2' U R2 U2'\n(R' U R' U') (R' F R2 U')\n(R' U' R U) R' F'", note: ""),
                Algorithm(name: "position corners 13", algorithm: "(R' U2 R U') (R' U2 R U2') (R' U' R U2') (R' U R U2') (R' U R)", note: ""),
                Algorithm(name: "position corners 14", algorithm: "(R2 U2' R2' U') (R2 U\nR2' U') (R2 U R2' U') (R2 U2' R2')", note: ""),
                Algorithm(name: "position corners 15", algorithm: "(R2 U2 R2' U) (R2\nU' R2' U) (R2 U' R2' U)\n(R2 U2 R2')", note: ""),
            ]),
            Category(name: "4X4 Parity", algorithms: [
                Algorithm(name: "four inline", algorithm: "Rw U2, X, Rw U2, Rw U2,\nRw' U2, Lw U2, Rw' U2,\nRw U2, Rw' U2, Rw'", note: "2 times"), //verified
                Algorithm(name: "single edge", algorithm: "r' U2 l F2 l' F2 r2 U2\nr U2 r' U2 F2 r2 F2", note: "2 times"), //verified
                Algorithm(name: "opposite edges", algorithm: "r2 U2 r2 Uw2 r2 u2", note: "2 times"), //verified
                Algorithm(name: "adjacent edges", algorithm: "(R' U R U') r2 U2 r2 Uw2\nr2 u2 (U R' U' R)", note: "2 times"), //verified
            ])
        ]
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundStyle(.yellow)
                    .ignoresSafeArea()
                VStack {
                    Text("Rubik's Cube Trainer!")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    Spacer()
                    ScrollView(showsIndicators: false) {
                        
                        Button(action: {}, label: {
                            NavigationLink("Timer", destination: TimerView()).padding(20)
                        })
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        
                        Button(action: {}, label: {
                            NavigationLink("CFOP Step Timer", destination: CFOPStepTimerView()).padding(20)
                        })
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        
                        Button(action: {}, label: {
                            NavigationLink("All Algorithms", destination: AllAlgorithmsView(categories: categories)).padding(20)
                        })
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        
                        Button(action: {}, label: {
                            NavigationLink("Simple OLL", destination: IndividualCategoryView(category: categories.first { $0.name == "Simple OLL" }!)).padding(20)
                        })
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        
                        Button(action: {}, label: {
                            NavigationLink("Simple PLL", destination: IndividualCategoryView(category: categories.first { $0.name == "Simple PLL" }!)).padding(20)
                        })
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        
                        Button(action: {}, label: {
                            NavigationLink("Full PLL", destination: IndividualCategoryView(category: categories.first { $0.name == "Full PLL" }!)).padding(20)
                        })
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        
                        Button(action: {}, label: {
                            NavigationLink("Full PLL List", destination: ListView(category: categories.first { $0.name == "Full PLL" }!)).padding(20)
                        })
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        
                        Button(action: {}, label: {
                            NavigationLink("F2L", destination: IndividualCategoryView(category: categories.first { $0.name == "F2L" }!)).padding(20)
                        })
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        
                        Button(action: {}, label: {
                            NavigationLink("F2L List", destination: ListView(category: categories.first { $0.name == "F2L" }!)).padding(20)
                        })
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        
                        Button(action: {}, label: {
                            NavigationLink("Megaminx OLL", destination: IndividualCategoryView(category: categories.first { $0.name == "Megaminx OLL" }!)).padding(20)
                        })
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        
                        Button(action: {}, label: {
                            NavigationLink("Megaminx OLL List", destination: ListView(category: categories.first { $0.name == "Megaminx OLL" }!)).padding(20)
                        })
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        
                        Button(action: {}, label: {
                            NavigationLink("Megaminx PLL", destination: IndividualCategoryView(category: categories.first { $0.name == "Megaminx PLL" }!)).padding(20)
                        })
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        
                        Button(action: {}, label: {
                            NavigationLink("Megaminx PLL List", destination: ListView(category: categories.first { $0.name == "Megaminx PLL" }!)).padding(20)
                        })
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        
                        Button(action: {}, label: {
                            NavigationLink("4X4 Parity", destination: IndividualCategoryView(category: categories.first { $0.name == "4X4 Parity" }!)).padding(20)
                        })
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        
                        Button(action: {}, label: {
                            NavigationLink("4X4 Parity List", destination: ListView(category: categories.first { $0.name == "4X4 Parity" }!)).padding(20)
                        })
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
