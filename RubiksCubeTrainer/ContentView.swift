//
//  ContentView.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 2025-03-20.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @EnvironmentObject var solveCountModel: SolveCountModel
    @EnvironmentObject var connectivity: PhoneConnectivity
    var isConnected: Bool {
        WCSession.default.isReachable
    }
    let color = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    @State var editCount = false
    // Start with empty array; load from UserDefaults if available
    @State private var needsWorkArrayMain: [Algorithm] = []
    var categories: [Category] = []

    init() {
        if let data = UserDefaults.standard.data(forKey: "needsWork"),
           let decoded = try? JSONDecoder().decode([Algorithm].self, from: data) {
            _needsWorkArrayMain = State(initialValue: decoded)
        }
        categories = [
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
                Algorithm(name: "F", algorithm: "R' U' F' R U R' U' R' F\nR2 U' R' U' R U R' U R", note: "2 times"),
                Algorithm(name: "F mirrored", algorithm: "L U F L' U' L U L F'\nL2 U L U L' U' L U' L'", note: "2 times"),
                Algorithm(name: "Ga", algorithm: "D' R2 U R' U R' U' R U' R2 (U' D) R' U R", note: "4 times"),
                Algorithm(name: "Gb", algorithm: "R' U' R (U D') R2 U R' U R U' R U' R2 D", note: "4 times"),
                Algorithm(name: "Gc", algorithm: "D L2 U' L U' L U L' U L2 (U D') L U' L'", note: "4 times"),
                Algorithm(name: "Gd", algorithm: "L U L' (U' D) L2 U' L U' L' U L' U L2 D'", note: "4 times"),
                Algorithm(name: "H", algorithm: "(M2 U' M2) U2\n(M2 U' M2)", note: "2 times"),
                Algorithm(name: "Z", algorithm: "M' U' M2 U' M2\nU' M' U2 M2 U", note: "2 times"),
                Algorithm(name: "Z mirrored", algorithm: "M' U M2 U M2\nU M' U2 M2 U'", note: "2 times"),
                Algorithm(name: "Ua", algorithm: "M2 U M U2 M' U M2", note: "3 times"),
                Algorithm(name: "Ub", algorithm: "M2 U' M U2 M' U' M2", note: "3 times"),
                Algorithm(name: "Aa", algorithm: "x z' R2 U2 (R' D' R) U2 (R' D R') z x'", note: "3 times"),
                Algorithm(name: "Aa mirrored", algorithm: "x z L2 U2 (L D L') U2 (L D' L) z' x'", note: "3 times"),
                Algorithm(name: "Ab", algorithm: "x (R2 D2) (R U R') D2\n(R U' R) x'", note: "3 times"),
                Algorithm(name: "Ab mirrored", algorithm: "x (L2 D2) (L' U' L) D2\n(L' U L') x'", note: "3 times"),
                Algorithm(name: "E", algorithm: "R2 U R' U' y (R U R' U') (R U R' U') (R U R') y' (R U' R2')", note: "2 times"),
                Algorithm(name: "Na", algorithm: "(R U R' U) (R U R' F') (R U R' U') R' F\nR2 U' R' U2 (R U' R')", note: "2 times"),
                Algorithm(name: "Nb", algorithm: "(L' U' L U') (L' U' L F) (L' U' L U) L F'\nL2 U L U2 (L' U L)", note: "2 times"),
                Algorithm(name: "T", algorithm: "(R U R' U') R' F\nR2 U' R' U' R U R' F'", note: "2 times"),
                Algorithm(name: "T mirrored", algorithm: "(L' U' L U) L F'\nL2 U L U L' U' L F", note: "2 times"),
                Algorithm(name: "Y", algorithm: "(F R U' R') U' (R U R' F') (R U R' U') (gR' F R F')", note: "2 times"),
                Algorithm(name: "Y mirrored", algorithm: "(F' L' U L) U (L' U' L F) (L' U' L U) (gL F' L' F)", note: "2 times"),
                Algorithm(name: "V", algorithm: "R2 D' R2' U R2 (U' D) R D' R D R' U R U' R", note: "2 times"),
                Algorithm(name: "V mirrored", algorithm: "L2 D L2 U' L2 (U D') L' D L' D' L U' L' U L'", note: "2 times"),
                Algorithm(name: "Ja", algorithm: "L' U' L F (L' U' L U) L F' L2 U L U", note: "2 times"),
                Algorithm(name: "Jb", algorithm: "R U R' F' (R U R' U') R' F R2 U' R' U'", note: "2 times"),
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
                
                Algorithm(name: "corner top edge middle 1", algorithm: "U' R U2' R' U R U R'", note: "", hasVid: true),
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
                Algorithm(name: "corner bottom edge top 6", algorithm: "y (L' U' L U) L' U' L", note: "", hasVid: true),
                
                Algorithm(name: "corner bottom edge middle 1", algorithm: "(R U' R' U) R U2 R' (U R U' R')", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge middle 2", algorithm: "(R U' R' U') (R U R' U') (R U2 R')", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge middle 3", algorithm: "(R U R' U') (R U' R') U d (R' U' R)", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge middle 4", algorithm: "(R U' R') d (R' U' R U') (R' U' R)", note: "", hasVid: true),
                Algorithm(name: "corner bottom edge middle 5", algorithm: "(R U' R' d R' U2 R) (U R' U2 R)", note: "", hasVid: true),
            ]),
            Category(name: "4X4 Parity", algorithms: [
                Algorithm(name: "four inline", algorithm: "Rw U2, X, Rw U2, Rw U2,\nRw' U2, Lw U2, Rw' U2,\nRw U2, Rw' U2, Rw'", note: "2 times"), //verified
                Algorithm(name: "single edge", algorithm: "r' U2 l F2 l' F2 r2 U2\nr U2 r' U2 F2 r2 F2", note: "2 times"), //verified
                Algorithm(name: "opposite edges", algorithm: "r2 U2 r2 Uw2 r2 u2", note: "2 times"), //verified
                Algorithm(name: "adjacent edges", algorithm: "(R' U R U') r2 U2 r2 Uw2\nr2 u2 (U R' U' R)", note: "2 times"), //verified
            ]),
            Category(name: "Needs Work", algorithms: needsWorkArrayMain),
            Category(name: "PLL Recognition", algorithms: [
                // EPLL
                // Category 1: One 3x1 Block
                // When the block is on the left:
                Algorithm(name: "one3x1leftopp1", algorithm: "(U) It’s Ub when an opposite edge color is on the right", note: ""),
                Algorithm(name: "one3x1leftopp2", algorithm: "(U) It’s Ub when an opposite edge color is on the right", note: ""),
                Algorithm(name: "one3x1leftopp3", algorithm: "(U) It’s Ub when an opposite edge color is on the right", note: ""),
                Algorithm(name: "one3x1leftopp4", algorithm: "(U) It’s Ub when an opposite edge color is on the right", note: ""),
                
                Algorithm(name: "one3x1leftadj1", algorithm: "(U) It’s Ua when an adjacent edge color is on the right", note: ""),
                Algorithm(name: "one3x1leftadj2", algorithm: "(U) It’s Ua when an adjacent edge color is on the right", note: ""),
                Algorithm(name: "one3x1leftadj3", algorithm: "(U) It’s Ua when an adjacent edge color is on the right", note: ""),
                Algorithm(name: "one3x1leftadj4", algorithm: "(U) It’s Ua when an adjacent edge color is on the right", note: ""),
                // When the block is on the right:
                Algorithm(name: "one3x1rightopp1", algorithm: "(U') It’s Ua when an opposite edge color is on the left", note: ""),
                Algorithm(name: "one3x1rightopp2", algorithm: "(U') It’s Ua when an opposite edge color is on the left", note: ""),
                Algorithm(name: "one3x1rightopp3", algorithm: "(U') It’s Ua when an opposite edge color is on the left", note: ""),
                Algorithm(name: "one3x1rightopp4", algorithm: "(U') It’s Ua when an opposite edge color is on the left", note: ""),
                
                Algorithm(name: "one3x1rightadj1", algorithm: "(U') It’s Ub when an adjacent edge color is on the left", note: ""),
                Algorithm(name: "one3x1rightadj2", algorithm: "(U') It’s Ub when an adjacent edge color is on the left", note: ""),
                Algorithm(name: "one3x1rightadj3", algorithm: "(U') It’s Ub when an adjacent edge color is on the left", note: ""),
                Algorithm(name: "one3x1rightadj4", algorithm: "(U') It’s Ub when an adjacent edge color is on the left", note: ""),
                
                // Category 2: No 3x1 Blocks & At Least One Opposite Edge
                Algorithm(name: "no3x1atleast1oppright1", algorithm: "(No rotation) It’s Ua when an opposite edge color is on the right", note: ""),
                Algorithm(name: "no3x1atleast1oppright2", algorithm: "(No rotation) It’s Ua when an opposite edge color is on the right", note: ""),
                Algorithm(name: "no3x1atleast1oppright3", algorithm: "(No rotation) It’s Ua when an opposite edge color is on the right", note: ""),
                Algorithm(name: "no3x1atleast1oppright4", algorithm: "(No rotation) It’s Ua when an opposite edge color is on the right", note: ""),
                
                Algorithm(name: "no3x1atleast1oppleft1", algorithm: "(U) It’s Ub when an opposite edge color is on the left", note: ""),
                Algorithm(name: "no3x1atleast1oppleft2", algorithm: "(U) It’s Ub when an opposite edge color is on the left", note: ""),
                Algorithm(name: "no3x1atleast1oppleft3", algorithm: "(U) It’s Ub when an opposite edge color is on the left", note: ""),
                Algorithm(name: "no3x1atleast1oppleft4", algorithm: "(U) It’s Ub when an opposite edge color is on the left", note: ""),
                
                Algorithm(name: "no3x1bothopp1", algorithm: "(No rotation) It’s H when an opposite edge color is on each side", note: ""),
                Algorithm(name: "no3x1bothopp2", algorithm: "(No rotation) It’s H when an opposite edge color is on each side", note: ""),
                Algorithm(name: "no3x1bothopp3", algorithm: "(No rotation) It’s H when an opposite edge color is on each side", note: ""),
                Algorithm(name: "no3x1bothopp4", algorithm: "(No rotation) It’s H when an opposite edge color is on each side", note: ""),
                
                // Category 3: No 3x1 Blocks & No Opposite Edges
                // When there are no opposite edges:
                Algorithm(name: "no3x1nooppcheckerleft1", algorithm: "(U) It’s Ua when a checker pattern is only on the left", note: ""),
                Algorithm(name: "no3x1nooppcheckerleft2", algorithm: "(U) It’s Ua when a checker pattern is only on the left", note: ""),
                Algorithm(name: "no3x1nooppcheckerleft3", algorithm: "(U) It’s Ua when a checker pattern is only on the left", note: ""),
                Algorithm(name: "no3x1nooppcheckerleft4", algorithm: "(U) It’s Ua when a checker pattern is only on the left", note: ""),
                
                Algorithm(name: "no3x1nooppcheckerright1", algorithm: "(No rotation) It’s Ub when a checker pattern is only on the right", note: ""),
                Algorithm(name: "no3x1nooppcheckerright2", algorithm: "(No rotation) It’s Ub when a checker pattern is only on the right", note: ""),
                Algorithm(name: "no3x1nooppcheckerright3", algorithm: "(No rotation) It’s Ub when a checker pattern is only on the right", note: ""),
                Algorithm(name: "no3x1nooppcheckerright4", algorithm: "(No rotation) It’s Ub when a checker pattern is only on the right", note: ""),
                // Otherwise:
                Algorithm(name: "no3x1nooppfullchecker1", algorithm: "(No rotation) No 3x1, no opposite edges, full checker pattern? It's Z.", note: ""),
                Algorithm(name: "no3x1nooppfullchecker2", algorithm: "(No rotation) No 3x1, no opposite edges, full checker pattern? It's Z.", note: ""),
                Algorithm(name: "no3x1nooppfullchecker3", algorithm: "(No rotation) No 3x1, no opposite edges, full checker pattern? It's Z.", note: ""),
                Algorithm(name: "no3x1nooppfullchecker4", algorithm: "(No rotation) No 3x1, no opposite edges, full checker pattern? It's Z.", note: ""),
                
                Algorithm(name: "no3x1nooppnochecker1", algorithm: "(No rotation) No 3x1, no opposite edges, no checker pattern? It's Z mirrored.", note: ""),
                Algorithm(name: "no3x1nooppnochecker2", algorithm: "(No rotation) No 3x1, no opposite edges, no checker pattern? It's Z mirrored.", note: ""),
                Algorithm(name: "no3x1nooppnochecker3", algorithm: "(No rotation) No 3x1, no opposite edges, no checker pattern? It's Z mirrored.", note: ""),
                Algorithm(name: "no3x1nooppnochecker4", algorithm: "(No rotation) No 3x1, no opposite edges, no checker pattern? It's Z mirrored.", note: ""),
                
                // Diagonal Corner Permutation
                // Category 1: Two Blocks
                Algorithm(name: "twoblocksinside1", algorithm: "(U) It’s V when the blocks are both on the inside and the colors on the outside are different", note: ""),
                Algorithm(name: "twoblocksinside2", algorithm: "(U) It’s V when the blocks are both on the inside and the colors on the outside are different", note: ""),
                Algorithm(name: "twoblocksinside3", algorithm: "(U) It’s V when the blocks are both on the inside and the colors on the outside are different", note: ""),
                Algorithm(name: "twoblocksinside4", algorithm: "(U) It’s V when the blocks are both on the inside and the colors on the outside are different", note: ""),
                
                Algorithm(name: "twoblocksoutside1", algorithm: "(No rotation) It’s Y when the blocks are both on the outside", note: ""),
                Algorithm(name: "twoblocksoutside2", algorithm: "(No rotation) It’s Y when the blocks are both on the outside", note: ""),
                Algorithm(name: "twoblocksoutside3", algorithm: "(No rotation) It’s Y when the blocks are both on the outside", note: ""),
                Algorithm(name: "twoblocksoutside4", algorithm: "(No rotation) It’s Y when the blocks are both on the outside", note: ""),
                
                Algorithm(name: "twoblocksleft1", algorithm: "(No rotation) It’s Na when the fully-visible corner is part of the left block and each side has opposite colors", note: ""),
                Algorithm(name: "twoblocksleft2", algorithm: "(No rotation) It’s Na when the fully-visible corner is part of the left block and each side has opposite colors", note: ""),
                Algorithm(name: "twoblocksleft3", algorithm: "(No rotation) It’s Na when the fully-visible corner is part of the left block and each side has opposite colors", note: ""),
                Algorithm(name: "twoblocksleft4", algorithm: "(No rotation) It’s Na when the fully-visible corner is part of the left block and each side has opposite colors", note: ""),
                
                Algorithm(name: "twoblocksright1", algorithm: "(No rotation) It’s Nb when the fully-visible corner is part of the right block and each side has opposite colors", note: ""),
                Algorithm(name: "twoblocksright2", algorithm: "(No rotation) It’s Nb when the fully-visible corner is part of the right block and each side has opposite colors", note: ""),
                Algorithm(name: "twoblocksright3", algorithm: "(No rotation) It’s Nb when the fully-visible corner is part of the right block and each side has opposite colors", note: ""),
                Algorithm(name: "twoblocksright4", algorithm: "(No rotation) It’s Nb when the fully-visible corner is part of the right block and each side has opposite colors", note: ""),
                
                // Category 2: One Block
                Algorithm(name: "oneblockoutside1", algorithm: "(No rotation) It’s V when there’s a block on the outside", note: ""),
                Algorithm(name: "oneblockoutside2", algorithm: "(No rotation) It’s V when there’s a block on the outside", note: ""),
                Algorithm(name: "oneblockoutside3", algorithm: "(No rotation) It’s V when there’s a block on the outside", note: ""),
                Algorithm(name: "oneblockoutside4", algorithm: "(No rotation) It’s V when there’s a block on the outside", note: ""),
                Algorithm(name: "oneblockoutside5", algorithm: "(U, mirrored alg) It’s V when there’s a block on the outside", note: ""),
                Algorithm(name: "oneblockoutside6", algorithm: "(U, mirrored alg) It’s V when there’s a block on the outside", note: ""),
                Algorithm(name: "oneblockoutside7", algorithm: "(U, mirrored alg) It’s V when there’s a block on the outside", note: ""),
                Algorithm(name: "oneblockoutside8", algorithm: "(U, mirrored alg) It’s V when there’s a block on the outside", note: ""),
                
                Algorithm(name: "oneblockinside1", algorithm: "(No rotation, mirrored) It’s Y when there’s a block on the inside and the corners are different", note: ""),
                Algorithm(name: "oneblockinside2", algorithm: "(No rotation, mirrored) It’s Y when there’s a block on the inside and the corners are different", note: ""),
                Algorithm(name: "oneblockinside3", algorithm: "(No rotation, mirrored) It’s Y when there’s a block on the inside and the corners are different", note: ""),
                Algorithm(name: "oneblockinside4", algorithm: "(No rotation, mirrored) It’s Y when there’s a block on the inside and the corners are different", note: ""),
                Algorithm(name: "oneblockinside5", algorithm: "(U) It’s Y when there’s a block on the inside and the corners are different", note: ""),
                Algorithm(name: "oneblockinside6", algorithm: "(U) It’s Y when there’s a block on the inside and the corners are different", note: ""),
                Algorithm(name: "oneblockinside7", algorithm: "(U) It’s Y when there’s a block on the inside and the corners are different", note: ""),
                Algorithm(name: "oneblockinside8", algorithm: "(U) It’s Y when there’s a block on the inside and the corners are different", note: ""),
                
                // Category 3: No Blocks
                Algorithm(name: "noblockscheckerinside1", algorithm: "(U') It’s V when there’s a checker pattern on the inside and the corners are different", note: ""),
                Algorithm(name: "noblockscheckerinside2", algorithm: "(U') It’s V when there’s a checker pattern on the inside and the corners are different", note: ""),
                Algorithm(name: "noblockscheckerinside3", algorithm: "(U') It’s V when there’s a checker pattern on the inside and the corners are different", note: ""),
                Algorithm(name: "noblockscheckerinside4", algorithm: "(U') It’s V when there’s a checker pattern on the inside and the corners are different", note: ""),
                
                Algorithm(name: "noblockscheckeroutside1", algorithm: "(U') It’s Y when there’s a checker pattern on the outside", note: ""),
                Algorithm(name: "noblockscheckeroutside2", algorithm: "(U') It’s Y when there’s a checker pattern on the outside", note: ""),
                Algorithm(name: "noblockscheckeroutside3", algorithm: "(U') It’s Y when there’s a checker pattern on the outside", note: ""),
                Algorithm(name: "noblockscheckeroutside4", algorithm: "(U') It’s Y when there’s a checker pattern on the outside", note: ""),
                
                Algorithm(name: "noblocksnochecker1", algorithm: "(No rotation) It’s E when there are no blocks and no checker in checker", note: ""),
                Algorithm(name: "noblocksnochecker2", algorithm: "(No rotation) It’s E when there are no blocks and no checker in checker", note: ""),
                Algorithm(name: "noblocksnochecker3", algorithm: "(No rotation) It’s E when there are no blocks and no checker in checker", note: ""),
                Algorithm(name: "noblocksnochecker4", algorithm: "(No rotation) It’s E when there are no blocks and no checker in checker", note: ""),
                Algorithm(name: "noblocksnochecker5", algorithm: "(U) It’s E when there are no blocks and no checker in checker", note: ""),
                Algorithm(name: "noblocksnochecker6", algorithm: "(U) It’s E when there are no blocks and no checker in checker", note: ""),
                Algorithm(name: "noblocksnochecker7", algorithm: "(U) It’s E when there are no blocks and no checker in checker", note: ""),
                Algorithm(name: "noblocksnochecker8", algorithm: "(U) It’s E when there are no blocks and no checker in checker", note: ""),
                
                // Adjacent Corner Permutation A
                // Category 1: A 3x1 Block & A 2x1 Block
                // When the 3x1 block is on the left
                Algorithm(name: "3x1left2x1inside1", algorithm: "(U') It's Ja when one color isn't solved on the right", note: ""),
                Algorithm(name: "3x1left2x1inside2", algorithm: "(U') It's Ja when one color isn't solved on the right", note: ""),
                Algorithm(name: "3x1left2x1inside3", algorithm: "(U') It's Ja when one color isn't solved on the right", note: ""),
                Algorithm(name: "3x1left2x1inside4", algorithm: "(U') It's Ja when one color isn't solved on the right", note: ""),
                
                Algorithm(name: "3x1left2x1outside1", algorithm: "(U) It's Jb when the 3x1 block is on the left and a block is on the right", note: ""),
                Algorithm(name: "3x1left2x1outside2", algorithm: "(U) It's Jb when the 3x1 block is on the left and a block is on the right", note: ""),
                Algorithm(name: "3x1left2x1outside3", algorithm: "(U) It's Jb when the 3x1 block is on the left and a block is on the right", note: ""),
                Algorithm(name: "3x1left2x1outside4", algorithm: "(U) It's Jb when the 3x1 block is on the left and a block is on the right", note: ""),
                // When the 3x1 block is on the right:
                Algorithm(name: "3x1right2x1inside1", algorithm: "(U2) It's Jb when one color isn't solved on the left", note: ""),
                Algorithm(name: "3x1right2x1inside2", algorithm: "(U2) It's Jb when one color isn't solved on the left", note: ""),
                Algorithm(name: "3x1right2x1inside3", algorithm: "(U2) It's Jb when one color isn't solved on the left", note: ""),
                Algorithm(name: "3x1right2x1inside4", algorithm: "(U2) It's Jb when one color isn't solved on the left", note: ""),
                
                Algorithm(name: "3x1right2x1outside1", algorithm: "(No rotation) It's Ja when the 3x1 block is on the right and a block is on the left", note: ""),
                Algorithm(name: "3x1right2x1outside2", algorithm: "(No rotation) It's Ja when the 3x1 block is on the right and a block is on the left", note: ""),
                Algorithm(name: "3x1right2x1outside3", algorithm: "(No rotation) It's Ja when the 3x1 block is on the right and a block is on the left", note: ""),
                Algorithm(name: "3x1right2x1outside4", algorithm: "(No rotation) It's Ja when the 3x1 block is on the right and a block is on the left", note: ""),
                
                // Category 2: One Outer 2x1 Block and One Inner 2x1 Block
                Algorithm(name: "1outerleft1inner1", algorithm: "(U) It’s Ja when the 2x1 block on the outside is on the left", note: ""),
                Algorithm(name: "1outerleft1inner2", algorithm: "(U) It’s Ja when the 2x1 block on the outside is on the left", note: ""),
                Algorithm(name: "1outerleft1inner3", algorithm: "(U) It’s Ja when the 2x1 block on the outside is on the left", note: ""),
                Algorithm(name: "1outerleft1inner4", algorithm: "(U) It’s Ja when the 2x1 block on the outside is on the left", note: ""),
                
                Algorithm(name: "1outerright1inner1", algorithm: "(No rotation) It’s Jb when the 2x1 block on the outside is on the right", note: ""),
                Algorithm(name: "1outerright1inner2", algorithm: "(No rotation) It’s Jb when the 2x1 block on the outside is on the right", note: ""),
                Algorithm(name: "1outerright1inner3", algorithm: "(No rotation) It’s Jb when the 2x1 block on the outside is on the right", note: ""),
                Algorithm(name: "1outerright1inner4", algorithm: "(No rotation) It’s Jb when the 2x1 block on the outside is on the right", note: ""),
                
                // Category 3: Two Inner 2x1 Blocks
                Algorithm(name: "2innerouterrightopp1", algorithm: "(U) It’s Aa when the outer corner on the right is opposite", note: ""),
                Algorithm(name: "2innerouterrightopp2", algorithm: "(U) It’s Aa when the outer corner on the right is opposite", note: ""),
                Algorithm(name: "2innerouterrightopp3", algorithm: "(U) It’s Aa when the outer corner on the right is opposite", note: ""),
                Algorithm(name: "2innerouterrightopp4", algorithm: "(U) It’s Aa when the outer corner on the right is opposite", note: ""),
                
                Algorithm(name: "2innerouterleftopp1", algorithm: "(U) It’s Ab when the outer corner on the left is opposite", note: ""),
                Algorithm(name: "2innerouterleftopp2", algorithm: "(U) It’s Ab when the outer corner on the left is opposite", note: ""),
                Algorithm(name: "2innerouterleftopp3", algorithm: "(U) It’s Ab when the outer corner on the left is opposite", note: ""),
                Algorithm(name: "2innerouterleftopp4", algorithm: "(U) It’s Ab when the outer corner on the left is opposite", note: ""),
                
                // Adjacent Corner Permutation B
                // Category 1: Inner Block
                Algorithm(name: "innerblockadjright1", algorithm: "(No rotation) It's Ra when the edge in between the headlights is adjacent and the block is on the right", note: ""),
                Algorithm(name: "innerblockadjright2", algorithm: "(No rotation) It's Ra when the edge in between the headlights is adjacent and the block is on the right", note: ""),
                Algorithm(name: "innerblockadjright3", algorithm: "(No rotation) It's Ra when the edge in between the headlights is adjacent and the block is on the right", note: ""),
                Algorithm(name: "innerblockadjright4", algorithm: "(No rotation) It's Ra when the edge in between the headlights is adjacent and the block is on the right", note: ""),
                
                Algorithm(name: "innerblockadjleft1", algorithm: "(U) It's Rb when the edge in between the headlights is adjacent and the block is on the left", note: ""),
                Algorithm(name: "innerblockadjleft2", algorithm: "(U) It's Rb when the edge in between the headlights is adjacent and the block is on the left", note: ""),
                Algorithm(name: "innerblockadjleft3", algorithm: "(U) It's Rb when the edge in between the headlights is adjacent and the block is on the left", note: ""),
                Algorithm(name: "innerblockadjleft4", algorithm: "(U) It's Rb when the edge in between the headlights is adjacent and the block is on the left", note: ""),
                
                Algorithm(name: "innerblockopp1", algorithm: "(U) It's T when the edge in between the headlights is opposite", note: ""),
                Algorithm(name: "innerblockopp2", algorithm: "(U) It's T when the edge in between the headlights is opposite", note: ""),
                Algorithm(name: "innerblockopp3", algorithm: "(U) It's T when the edge in between the headlights is opposite", note: ""),
                Algorithm(name: "innerblockopp4", algorithm: "(U) It's T when the edge in between the headlights is opposite", note: ""),
                
                Algorithm(name: "innerblockopp5", algorithm: "(No rotation, mirrored) It's T when the edge in between the headlights is opposite", note: ""),
                Algorithm(name: "innerblockopp6", algorithm: "(No rotation, mirrored) It's T when the edge in between the headlights is opposite", note: ""),
                Algorithm(name: "innerblockopp7", algorithm: "(No rotation, mirrored) It's T when the edge in between the headlights is opposite", note: ""),
                Algorithm(name: "innerblockopp8", algorithm: "(No rotation, mirrored) It's T when the edge in between the headlights is opposite", note: ""),
                
                // Category 2: Outer Block
                Algorithm(name: "outerblockrightcheckered1", algorithm: "(U) It’s Ab mirrored when the block is on the right and it's checkered", note: ""),
                Algorithm(name: "outerblockrightcheckered2", algorithm: "(U) It’s Ab mirrored when the block is on the right and it's checkered", note: ""),
                Algorithm(name: "outerblockrightcheckered3", algorithm: "(U) It’s Ab mirrored when the block is on the right and it's checkered", note: ""),
                Algorithm(name: "outerblockrightcheckered4", algorithm: "(U) It’s Ab mirrored when the block is on the right and it's checkered", note: ""),
                
                Algorithm(name: "outerblockleftcheckered1", algorithm: "(No rotation) It’s Ab when the block is on the left and it's checkered", note: ""),
                Algorithm(name: "outerblockleftcheckered2", algorithm: "(No rotation) It’s Ab when the block is on the left and it's checkered", note: ""),
                Algorithm(name: "outerblockleftcheckered3", algorithm: "(No rotation) It’s Ab when the block is on the left and it's checkered", note: ""),
                Algorithm(name: "outerblockleftcheckered4", algorithm: "(No rotation) It’s Ab when the block is on the left and it's checkered", note: ""),
                
                Algorithm(name: "outerblockrightnotcheckered1", algorithm: "(U) It’s Ga when the block is on the right and it's not checkered", note: ""),
                Algorithm(name: "outerblockrightnotcheckered2", algorithm: "(U) It’s Ga when the block is on the right and it's not checkered", note: ""),
                Algorithm(name: "outerblockrightnotcheckered3", algorithm: "(U) It’s Ga when the block is on the right and it's not checkered", note: ""),
                Algorithm(name: "outerblockrightnotcheckered4", algorithm: "(U) It’s Ga when the block is on the right and it's not checkered", note: ""),
                
                Algorithm(name: "outerblockleftnotcheckered1", algorithm: "(No rotation) It’s Gc when the block is on the left and it's not checkered", note: ""),
                Algorithm(name: "outerblockleftnotcheckered2", algorithm: "(No rotation) It’s Gc when the block is on the left and it's not checkered", note: ""),
                Algorithm(name: "outerblockleftnotcheckered3", algorithm: "(No rotation) It’s Gc when the block is on the left and it's not checkered", note: ""),
                Algorithm(name: "outerblockleftnotcheckered4", algorithm: "(No rotation) It’s Gc when the block is on the left and it's not checkered", note: ""),
                
                // Adjacent Corner Permutation C
                // Category 1: A 3x1 Block
                Algorithm(name: "3x1oppadj1", algorithm: "(U) It's F when there's a 3x1 block on the left and the colors go opposite adjacent", note: ""),
                Algorithm(name: "3x1oppadj2", algorithm: "(U) It's F when there's a 3x1 block on the left and the colors go opposite adjacent", note: ""),
                Algorithm(name: "3x1oppadj3", algorithm: "(U) It's F when there's a 3x1 block on the left and the colors go opposite adjacent", note: ""),
                Algorithm(name: "3x1oppadj4", algorithm: "(U) It's F when there's a 3x1 block on the left and the colors go opposite adjacent", note: ""),
                
                Algorithm(name: "3x1oppadj5", algorithm: "(No rotation) It's F when there's a 3x1 block on the right and the colors go opposite adjacent", note: ""),
                Algorithm(name: "3x1oppadj6", algorithm: "(No rotation) It's F when there's a 3x1 block on the right and the colors go opposite adjacent", note: ""),
                Algorithm(name: "3x1oppadj7", algorithm: "(No rotation) It's F when there's a 3x1 block on the right and the colors go opposite adjacent", note: ""),
                Algorithm(name: "3x1oppadj8", algorithm: "(No rotation) It's F when there's a 3x1 block on the right and the colors go opposite adjacent", note: ""),
                
                // Category 2: Inner Block
                Algorithm(name: "inneradjleft1", algorithm: "(No rotation) It’s Ga when the inner block is on the left and the corner beside the block is adjacent", note: ""),
                Algorithm(name: "inneradjleft2", algorithm: "(No rotation) It’s Ga when the inner block is on the left and the corner beside the block is adjacent", note: ""),
                Algorithm(name: "inneradjleft3", algorithm: "(No rotation) It’s Ga when the inner block is on the left and the corner beside the block is adjacent", note: ""),
                Algorithm(name: "inneradjleft4", algorithm: "(No rotation) It’s Ga when the inner block is on the left and the corner beside the block is adjacent", note: ""),
                
                Algorithm(name: "inneradjright1", algorithm: "(U) It’s Gc when the inner block is on the right and the corner beside the block is adjacent", note: ""),
                Algorithm(name: "inneradjright2", algorithm: "(U) It’s Gc when the inner block is on the right and the corner beside the block is adjacent", note: ""),
                Algorithm(name: "inneradjright3", algorithm: "(U) It’s Gc when the inner block is on the right and the corner beside the block is adjacent", note: ""),
                Algorithm(name: "inneradjright4", algorithm: "(U) It’s Gc when the inner block is on the right and the corner beside the block is adjacent", note: ""),
                
                Algorithm(name: "inneroppleft1", algorithm: "(U') It’s Gb when the inner block is on the left and the corner beside the block is opposite", note: ""),
                Algorithm(name: "inneroppleft2", algorithm: "(U') It’s Gb when the inner block is on the left and the corner beside the block is opposite", note: ""),
                Algorithm(name: "inneroppleft3", algorithm: "(U') It’s Gb when the inner block is on the left and the corner beside the block is opposite", note: ""),
                Algorithm(name: "inneroppleft4", algorithm: "(U') It’s Gb when the inner block is on the left and the corner beside the block is opposite", note: ""),
                
                Algorithm(name: "inneroppright1", algorithm: "(U2) It’s Gd when the inner block is on the right and the corner beside the block is opposite", note: ""),
                Algorithm(name: "inneroppright2", algorithm: "(U2) It’s Gd when the inner block is on the right and the corner beside the block is opposite", note: ""),
                Algorithm(name: "inneroppright3", algorithm: "(U2) It’s Gd when the inner block is on the right and the corner beside the block is opposite", note: ""),
                Algorithm(name: "inneroppright4", algorithm: "(U2) It’s Gd when the inner block is on the right and the corner beside the block is opposite", note: ""),
                
                // Category 3: Outer Block & Opposite Corner
                Algorithm(name: "outerrightopp1", algorithm: "(No rotation) It’s Gb when the outer block is on the right and it checkers in the middle", note: ""),
                Algorithm(name: "outerrightopp2", algorithm: "(No rotation) It’s Gb when the outer block is on the right and it checkers in the middle", note: ""),
                Algorithm(name: "outerrightopp3", algorithm: "(No rotation) It’s Gb when the outer block is on the right and it checkers in the middle", note: ""),
                Algorithm(name: "outerrightopp4", algorithm: "(No rotation) It’s Gb when the outer block is on the right and it checkers in the middle", note: ""),
                
                Algorithm(name: "outerleftopp1", algorithm: "(U) It’s Gd when the outer block is on the left and it checkers in the middle", note: ""),
                Algorithm(name: "outerleftopp2", algorithm: "(U) It’s Gd when the outer block is on the left and it checkers in the middle", note: ""),
                Algorithm(name: "outerleftopp3", algorithm: "(U) It’s Gd when the outer block is on the left and it checkers in the middle", note: ""),
                Algorithm(name: "outerleftopp4", algorithm: "(U) It’s Gd when the outer block is on the left and it checkers in the middle", note: ""),
                
                Algorithm(name: "outerleftoppnochecker1", algorithm: "(No rotation) It’s Aa when the outer block is on the left and it doesn't checker in the middle", note: ""),
                Algorithm(name: "outerleftoppnochecker2", algorithm: "(No rotation) It’s Aa when the outer block is on the left and it doesn't checker in the middle", note: ""),
                Algorithm(name: "outerleftoppnochecker3", algorithm: "(No rotation) It’s Aa when the outer block is on the left and it doesn't checker in the middle", note: ""),
                Algorithm(name: "outerleftoppnochecker4", algorithm: "(No rotation) It’s Aa when the outer block is on the left and it doesn't checker in the middle", note: ""),
                
                Algorithm(name: "outerrightoppnochecker1", algorithm: "(U) It’s Aa mirrored when the outer block is on the right and it doesn't checker in the middle", note: ""),
                Algorithm(name: "outerrightoppnochecker2", algorithm: "(U) It’s Aa mirrored when the outer block is on the right and it doesn't checker in the middle", note: ""),
                Algorithm(name: "outerrightoppnochecker3", algorithm: "(U) It’s Aa mirrored when the outer block is on the right and it doesn't checker in the middle", note: ""),
                Algorithm(name: "outerrightoppnochecker4", algorithm: "(U) It’s Aa mirrored when the outer block is on the right and it doesn't checker in the middle", note: ""),
                
                // Category 4: Outer Block & Adjacent Corner
                Algorithm(name: "outerleftadjchecker1", algorithm: "(U') It’s Ra when the block is on the left and it checkers in the middle (more adj colors)", note: ""),
                Algorithm(name: "outerleftadjchecker2", algorithm: "(U') It’s Ra when the block is on the left and it checkers in the middle (more adj colors)", note: ""),
                Algorithm(name: "outerleftadjchecker3", algorithm: "(U') It’s Ra when the block is on the left and it checkers in the middle (more adj colors)", note: ""),
                Algorithm(name: "outerleftadjchecker4", algorithm: "(U') It’s Ra when the block is on the left and it checkers in the middle (more adj colors)", note: ""),
                
                Algorithm(name: "outerrightadjchecker1", algorithm: "(U2) It’s Rb when the block is on the right and it checkers in the middle (more adj colors)", note: ""),
                Algorithm(name: "outerrightadjchecker2", algorithm: "(U2) It’s Rb when the block is on the right and it checkers in the middle (more adj colors)", note: ""),
                Algorithm(name: "outerrightadjchecker3", algorithm: "(U2) It’s Rb when the block is on the right and it checkers in the middle (more adj colors)", note: ""),
                Algorithm(name: "outerrightadjchecker4", algorithm: "(U2) It’s Rb when the block is on the right and it checkers in the middle (more adj colors)", note: ""),
                
                Algorithm(name: "outerleftadjnochecker1", algorithm: "(No rotation) It’s T when the block is on the left and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
                Algorithm(name: "outerleftadjnochecker2", algorithm: "(No rotation) It’s T when the block is on the left and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
                Algorithm(name: "outerleftadjnochecker3", algorithm: "(No rotation) It’s T when the block is on the left and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
                Algorithm(name: "outerleftadjnochecker4", algorithm: "(No rotation) It’s T when the block is on the left and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
                
                Algorithm(name: "outerrightadjnochecker1", algorithm: "(U) It’s T mirrored when the block is on the right and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
                Algorithm(name: "outerrightadjnochecker2", algorithm: "(U) It’s T mirrored when the block is on the right and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
                Algorithm(name: "outerrightadjnochecker3", algorithm: "(U) It’s T mirrored when the block is on the right and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
                Algorithm(name: "outerrightadjnochecker4", algorithm: "(U) It’s T mirrored when the block is on the right and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
                
                // Adjacent Corner Permutation D
                // Category 1: Opposite Edge In Between Headlights
                Algorithm(name: "oppinhead3right1", algorithm: "(U2) It’s Gb when there are 3 colors and the headlights are on the right containing the opposite color", note: ""),
                Algorithm(name: "oppinhead3right2", algorithm: "(U2) It’s Gb when there are 3 colors and the headlights are on the right containing the opposite color", note: ""),
                Algorithm(name: "oppinhead3right3", algorithm: "(U2) It’s Gb when there are 3 colors and the headlights are on the right containing the opposite color", note: ""),
                Algorithm(name: "oppinhead3right4", algorithm: "(U2) It’s Gb when there are 3 colors and the headlights are on the right containing the opposite color", note: ""),
                
                Algorithm(name: "oppinhead3left1", algorithm: "(U') It’s Gd when there are 3 colors and the headlights are on the left containing the opposite color", note: ""),
                Algorithm(name: "oppinhead3left2", algorithm: "(U') It’s Gd when there are 3 colors and the headlights are on the left containing the opposite color", note: ""),
                Algorithm(name: "oppinhead3left3", algorithm: "(U') It’s Gd when there are 3 colors and the headlights are on the left containing the opposite color", note: ""),
                Algorithm(name: "oppinhead3left4", algorithm: "(U') It’s Gd when there are 3 colors and the headlights are on the left containing the opposite color", note: ""),
                
                Algorithm(name: "oppinheadleft1", algorithm: "(U) It’s Gb when there's an opposite color in the headlights on the left (and no other pattern)", note: ""),
                Algorithm(name: "oppinheadleft2", algorithm: "(U) It’s Gb when there's an opposite color in the headlights on the left (and no other pattern)", note: ""),
                Algorithm(name: "oppinheadleft3", algorithm: "(U) It’s Gb when there's an opposite color in the headlights on the left (and no other pattern)", note: ""),
                Algorithm(name: "oppinheadleft4", algorithm: "(U) It’s Gb when there's an opposite color in the headlights on the left (and no other pattern)", note: ""),
                
                Algorithm(name: "oppinheadright1", algorithm: "(No rotation) It’s Gd when there's an opposite color in the headlights on the right (and no other pattern)", note: ""),
                Algorithm(name: "oppinheadright2", algorithm: "(No rotation) It’s Gd when there's an opposite color in the headlights on the right (and no other pattern)", note: ""),
                Algorithm(name: "oppinheadright3", algorithm: "(No rotation) It’s Gd when there's an opposite color in the headlights on the right (and no other pattern)", note: ""),
                Algorithm(name: "oppinheadright4", algorithm: "(No rotation) It’s Gd when there's an opposite color in the headlights on the right (and no other pattern)", note: ""),
                
                // Category 2: Adjacent Edge In Between Headlights
                Algorithm(name: "adjinheadleft1", algorithm: "(No rotation) It’s Rb when there's an adjacent color in the headlights on the left with an extended checker pattern", note: ""),
                Algorithm(name: "adjinheadleft2", algorithm: "(No rotation) It’s Rb when there's an adjacent color in the headlights on the left with an extended checker pattern", note: ""),
                Algorithm(name: "adjinheadleft3", algorithm: "(No rotation) It’s Rb when there's an adjacent color in the headlights on the left with an extended checker pattern", note: ""),
                Algorithm(name: "adjinheadleft4", algorithm: "(No rotation) It’s Rb when there's an adjacent color in the headlights on the left with an extended checker pattern", note: ""),
                
                Algorithm(name: "adjinheadright1", algorithm: "(U) It’s Ra when there's an adjacent color in the headlights on the right with an extended checker pattern", note: ""),
                Algorithm(name: "adjinheadright2", algorithm: "(U) It’s Ra when there's an adjacent color in the headlights on the right with an extended checker pattern", note: ""),
                Algorithm(name: "adjinheadright3", algorithm: "(U) It’s Ra when there's an adjacent color in the headlights on the right with an extended checker pattern", note: ""),
                Algorithm(name: "adjinheadright4", algorithm: "(U) It’s Ra when there's an adjacent color in the headlights on the right with an extended checker pattern", note: ""),
                
                Algorithm(name: "adjinheadrightchecker1", algorithm: "(U2) It’s Ga when there's an adjacent color in the headlights on the right and there is a checker pattern", note: ""),
                Algorithm(name: "adjinheadrightchecker2", algorithm: "(U2) It’s Ga when there's an adjacent color in the headlights on the right and there is a checker pattern", note: ""),
                Algorithm(name: "adjinheadrightchecker3", algorithm: "(U2) It’s Ga when there's an adjacent color in the headlights on the right and there is a checker pattern", note: ""),
                Algorithm(name: "adjinheadrightchecker4", algorithm: "(U2) It’s Ga when there's an adjacent color in the headlights on the right and there is a checker pattern", note: ""),
                
                Algorithm(name: "adjinheadleftchecker1", algorithm: "(U') It’s Gc when when there's an adjacent color in the headlights on the left and there is a checker pattern", note: ""),
                Algorithm(name: "adjinheadleftchecker2", algorithm: "(U') It’s Gc when when there's an adjacent color in the headlights on the left and there is a checker pattern", note: ""),
                Algorithm(name: "adjinheadleftchecker3", algorithm: "(U') It’s Gc when when there's an adjacent color in the headlights on the left and there is a checker pattern", note: ""),
                Algorithm(name: "adjinheadleftchecker4", algorithm: "(U') It’s Gc when when there's an adjacent color in the headlights on the left and there is a checker pattern", note: ""),
                
                Algorithm(name: "adjinheadrightnochecker1", algorithm: "(U') It’s Aa when when there's an adjacent color in the headlights on the right and there is no checker pattern", note: ""),
                Algorithm(name: "adjinheadrightnochecker2", algorithm: "(U') It’s Aa when when there's an adjacent color in the headlights on the right and there is no checker pattern", note: ""),
                Algorithm(name: "adjinheadrightnochecker3", algorithm: "(U') It’s Aa when when there's an adjacent color in the headlights on the right and there is no checker pattern", note: ""),
                Algorithm(name: "adjinheadrightnochecker4", algorithm: "(U') It’s Aa when when there's an adjacent color in the headlights on the right and there is no checker pattern", note: ""),
                
                Algorithm(name: "adjinheadleftnochecker1", algorithm: "(U') It’s Ab when when there's an adjacent color in the headlights on the left and there is no checker pattern", note: ""),
                Algorithm(name: "adjinheadleftnochecker2", algorithm: "(U') It’s Ab when when there's an adjacent color in the headlights on the left and there is no checker pattern", note: ""),
                Algorithm(name: "adjinheadleftnochecker3", algorithm: "(U') It’s Ab when when there's an adjacent color in the headlights on the left and there is no checker pattern", note: ""),
                Algorithm(name: "adjinheadleftnochecker4", algorithm: "(U') It’s Ab when when there's an adjacent color in the headlights on the left and there is no checker pattern", note: ""),
                
                // Adjacent Corner Permutation E
                Algorithm(name: "3colorcheckermiddle1", algorithm: "(U') It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
                Algorithm(name: "3colorcheckermiddle2", algorithm: "(U') It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
                Algorithm(name: "3colorcheckermiddle3", algorithm: "(U') It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
                Algorithm(name: "3colorcheckermiddle4", algorithm: "(U') It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
                Algorithm(name: "3colorcheckermiddle5", algorithm: "(No rotation) It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
                Algorithm(name: "3colorcheckermiddle6", algorithm: "(No rotation) It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
                Algorithm(name: "3colorcheckermiddle7", algorithm: "(No rotation) It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
                Algorithm(name: "3colorcheckermiddle8", algorithm: "(No rotation) It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
                
                Algorithm(name: "oppoutercornerright1", algorithm: "(U') It’s Ga when it's checker within checker and there are more opposite colors in the middle", note: ""),
                Algorithm(name: "oppoutercornerright2", algorithm: "(U') It’s Ga when it's checker within checker and there are more opposite colors in the middle", note: ""),
                Algorithm(name: "oppoutercornerright3", algorithm: "(U') It’s Ga when it's checker within checker and there are more opposite colors in the middle", note: ""),
                Algorithm(name: "oppoutercornerright4", algorithm: "(U') It’s Ga when it's checker within checker and there are more opposite colors in the middle", note: ""),
                
                Algorithm(name: "oppoutercornerleft1", algorithm: "(U2) It’s Gc when it's checker within checker and there are more opposite colors in the middle", note: ""),
                Algorithm(name: "oppoutercornerleft2", algorithm: "(U2) It’s Gc when it's checker within checker and there are more opposite colors in the middle", note: ""),
                Algorithm(name: "oppoutercornerleft3", algorithm: "(U2) It’s Gc when it's checker within checker and there are more opposite colors in the middle", note: ""),
                Algorithm(name: "oppoutercornerleft4", algorithm: "(U2) It’s Gc when it's checker within checker and there are more opposite colors in the middle", note: ""),
                
                Algorithm(name: "oppinnercornerright1", algorithm: "(U2) It’s Ra when it's checker within checker and there are more adj colors in the middle", note: ""),
                Algorithm(name: "oppinnercornerright2", algorithm: "(U2) It’s Ra when it's checker within checker and there are more adj colors in the middle", note: ""),
                Algorithm(name: "oppinnercornerright3", algorithm: "(U2) It’s Ra when it's checker within checker and there are more adj colors in the middle", note: ""),
                Algorithm(name: "oppinnercornerright4", algorithm: "(U2) It’s Ra when it's checker within checker and there are more adj colors in the middle", note: ""),
                
                Algorithm(name: "oppinnercornerleft1", algorithm: "(U') It’s Rb when it's checker within checker and there are more adj colors in the middle", note: ""),
                Algorithm(name: "oppinnercornerleft2", algorithm: "(U') It’s Rb when it's checker within checker and there are more adj colors in the middle", note: ""),
                Algorithm(name: "oppinnercornerleft3", algorithm: "(U') It’s Rb when it's checker within checker and there are more adj colors in the middle", note: ""),
                Algorithm(name: "oppinnercornerleft4", algorithm: "(U') It’s Rb when it's checker within checker and there are more adj colors in the middle", note: ""),
            ]),
            Category(name: "PLL Abridged", algorithms: [
                Algorithm(name: "oneblockoutside1", algorithm: "(No rotation) It’s V when there’s a block on the outside", note: ""),
                Algorithm(name: "oneblockoutside5", algorithm: "(U, mirrored alg) It’s V when there’s a block on the outside", note: ""),
                Algorithm(name: "oneblockinside1", algorithm: "(No rotation, mirrored) It’s Y when there’s a block on the inside and the corners are different", note: ""),
                Algorithm(name: "oneblockinside5", algorithm: "(U) It’s Y when there’s a block on the inside and the corners are different", note: ""),
                Algorithm(name: "noblockscheckerinside1", algorithm: "(U') It’s V when there’s a checker pattern on the inside and the corners are different", note: ""),
                Algorithm(name: "noblockscheckeroutside1", algorithm: "(U') It’s Y when there’s a checker pattern on the outside", note: ""),
                Algorithm(name: "noblocksnochecker1", algorithm: "(No rotation) It’s E when there are no blocks and no checker in checker", note: ""),
                Algorithm(name: "noblocksnochecker5", algorithm: "(U) It’s E when there are no blocks and no checker in checker", note: ""),
                Algorithm(name: "outerblockrightnotcheckered1", algorithm: "(U) It’s Ga when the block is on the right and it's not checkered", note: ""),
                Algorithm(name: "outerblockleftnotcheckered1", algorithm: "(No rotation) It’s Gc when the block is on the left and it's not checkered", note: ""),
                Algorithm(name: "inneradjleft1", algorithm: "(No rotation) It’s Ga when the inner block is on the left and the corner beside the block is adjacent", note: ""),
                Algorithm(name: "inneradjright1", algorithm: "(U) It’s Gc when the inner block is on the right and the corner beside the block is adjacent", note: ""),
                Algorithm(name: "inneroppleft1", algorithm: "(U') It’s Gb when the inner block is on the left and the corner beside the block is opposite", note: ""),
                Algorithm(name: "inneroppright1", algorithm: "(U2) It’s Gd when the inner block is on the right and the corner beside the block is opposite", note: ""),
                Algorithm(name: "outerrightopp1", algorithm: "(No rotation) It’s Gb when the outer block is on the right and it checkers in the middle", note: ""),
                Algorithm(name: "outerleftopp1", algorithm: "(U) It’s Gd when the outer block is on the left and it checkers in the middle", note: ""),
                Algorithm(name: "outerleftoppnochecker1", algorithm: "(No rotation) It’s Aa when the outer block is on the left and it doesn't checker in the middle", note: ""),
                Algorithm(name: "outerrightoppnochecker1", algorithm: "(U) It’s Aa mirrored when the outer block is on the right and it doesn't checker in the middle", note: ""),
                Algorithm(name: "outerleftadjchecker1", algorithm: "(U') It’s Ra when the block is on the left and it checkers in the middle (more adj colors)", note: ""),
                Algorithm(name: "outerrightadjchecker1", algorithm: "(U2) It’s Rb when the block is on the right and it checkers in the middle (more adj colors)", note: ""),
                Algorithm(name: "outerleftadjnochecker1", algorithm: "(No rotation) It’s T when the block is on the left and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
                Algorithm(name: "outerrightadjnochecker1", algorithm: "(U) It’s T mirrored when the block is on the right and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
                Algorithm(name: "oppinhead3right1", algorithm: "(U2) It’s Gb when there are 3 colors and the headlights are on the right containing the opposite color", note: ""),
                Algorithm(name: "oppinhead3left1", algorithm: "(U') It’s Gd when there are 3 colors and the headlights are on the left containing the opposite color", note: ""),
                Algorithm(name: "oppinheadleft1", algorithm: "(U) It’s Gb when there's an opposite color in the headlights on the left (and no other pattern)", note: ""),
                Algorithm(name: "oppinheadright1", algorithm: "(No rotation) It’s Gd when there's an opposite color in the headlights on the right (and no other pattern)", note: ""),
                Algorithm(name: "adjinheadleft1", algorithm: "(No rotation) It’s Rb when there's an adjacent color in the headlights on the left with an extended checker pattern", note: ""),
                Algorithm(name: "adjinheadright1", algorithm: "(U) It’s Ra when there's an adjacent color in the headlights on the right with an extended checker pattern", note: ""),
                Algorithm(name: "adjinheadrightchecker1", algorithm: "(U2) It’s Ga when there's an adjacent color in the headlights on the right and there is a checker pattern", note: ""),
                Algorithm(name: "adjinheadleftchecker1", algorithm: "(U') It’s Gc when when there's an adjacent color in the headlights on the left and there is a checker pattern", note: ""),
                Algorithm(name: "adjinheadrightnochecker1", algorithm: "(U') It’s Aa when when there's an adjacent color in the headlights on the right and there is no checker pattern", note: ""),
                Algorithm(name: "adjinheadleftnochecker1", algorithm: "(U') It’s Ab when when there's an adjacent color in the headlights on the left and there is no checker pattern", note: ""),
                Algorithm(name: "3colorcheckermiddle1", algorithm: "(U') It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
                Algorithm(name: "3colorcheckermiddle5", algorithm: "(No rotation) It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
                Algorithm(name: "oppoutercornerright1", algorithm: "(U') It’s Ga when it's checker within checker and there are more opposite colors in the middle", note: ""),
                Algorithm(name: "oppoutercornerleft1", algorithm: "(U2) It’s Gc when it's checker within checker and there are more opposite colors in the middle", note: ""),
                Algorithm(name: "oppinnercornerright1", algorithm: "(U2) It’s Ra when it's checker within checker and there are more adj colors in the middle", note: ""),
                Algorithm(name: "oppinnercornerleft1", algorithm: "(U') It’s Rb when it's checker within checker and there are more adj colors in the middle", note: ""),
                Algorithm(name: "1outerleft1inner1", algorithm: "(U) It’s Ja when the 2x1 block on the outside is on the left", note: ""),
                Algorithm(name: "1outerright1inner1", algorithm: "(No rotation) It’s Jb when the 2x1 block on the outside is on the right", note: ""),
                Algorithm(name: "outerblockrightcheckered1", algorithm: "(U) It’s Ab mirrored when the block is on the right and it's checkered", note: ""),
                Algorithm(name: "outerblockleftcheckered1", algorithm: "(No rotation) It’s Ab when the block is on the left and it's checkered", note: ""),
            ])
        ]
    }
    @State var selectedCategoryForList: Category?
    @State var showListView = false
    @State var selectedCategoryForIndividual: Category?
    @State var showIndividualView = false
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundStyle(.yellow)
                    .ignoresSafeArea()
                // Watch connected indicator
                VStack {
                    HStack {
                        Spacer()
                        Text(isConnected ? "✅" : "⚠️")
                            .font(.footnote)
                            .padding(.horizontal, 20)
                            .padding(.top, -10)
                    }
                    Spacer()
                }
                
                VStack {
                    Text("Rubik's Cube Trainer!")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .padding(.top, 65)
                    Spacer()
                    ScrollView(showsIndicators: false) {
                        VStack {
                            NavigationLink(destination: TimerView()) {
                                Text("Timer")
                                    .capsuleButtonStyle()
                            }
                            
                            NavigationLink(destination: CFOPStepTimerView()) {
                                Text("CFOP Step Timer")
                                    .capsuleButtonStyle()
                            }
                            
                            //                        NavigationLink(destination: AllAlgorithmsView(categories: categories)) {
                            //                            Text("All Algorithms")
                            //                                .capsuleButtonStyle()
                            //                        }
                            
                            //                        NavigationLink(destination: IndividualCategoryView(category: categories.first { $0.name == "Simple OLL" }!)) {
                            //                            Text("Simple OLL")
                            //                                .capsuleButtonStyle()
                            //                        }
                            //
                            //                        NavigationLink(destination: IndividualCategoryView(category: categories.first { $0.name == "Simple PLL" }!)) {
                            //                            Text("Simple PLL")
                            //                                .capsuleButtonStyle()
                            //                        }
                            
                            if let category = categories.first(where: { $0.name == "F2L" }),
                               !category.algorithms.isEmpty {
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
                            
                            NavigationLink(destination: AdvancedF2LView()) {
                                Text("Advanced F2L >")
                                    .capsuleButtonStyle(color: .red)
                            }
                            
                            if !needsWorkArrayMain.isEmpty {
                                NavigationLink(
                                        destination: IndividualCategoryView(
                                            category: Category(name: "Needs Work", algorithms: needsWorkArrayMain)
                                        )
                                    ) {
                                    Text("Weak Algorithms (\(needsWorkArrayMain.count))")
                                        .capsuleButtonStyle()
                                }
                            }
                            
                            NavigationLink(destination: FullOLLView()) {
                                Text("Full OLL >")
                                    .capsuleButtonStyle(color: .red)
                            }
                            
                            if let category = categories.first(where: { $0.name == "Full PLL" }),
                               !category.algorithms.isEmpty {
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
                            
                            if let category = categories.first(where: { $0.name == "PLL Abridged" }),
                               !category.algorithms.isEmpty {
                                Button(action: {
                                    selectedCategoryForIndividual = category
                                    showIndividualView = true
                                }) {
                                    Text("PLL Rec Abridged (\(category.algorithms.count))")
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
                            
                            if let category = categories.first(where: { $0.name == "PLL Recognition" }),
                               !category.algorithms.isEmpty {
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
                            
                            if let category = categories.first(where: { $0.name == "4X4 Parity" }),
                               !category.algorithms.isEmpty {
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
                            
                            NavigationLink(destination: MegaminxView()) {
                                Text("Megaminx >")
                                    .capsuleButtonStyle()
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
            .onAppear {
                if let data = UserDefaults.standard.data(forKey: "needsWork"),
                   let decoded = try? JSONDecoder().decode([Algorithm].self, from: data) {
                    needsWorkArrayMain = decoded
                    print("✅ Refreshed needsWorkArrayMain: \(decoded.count) items")
                } else {
                    needsWorkArrayMain = []
                    print("⚠️ No needsWork data found")
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [SolveTime.self, CFOPSolveTime.self])
        .environmentObject(SolveCountModel())
}
