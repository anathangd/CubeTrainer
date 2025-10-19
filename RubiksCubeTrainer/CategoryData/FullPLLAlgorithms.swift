//
//  FullPLLAlgorithms.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 10/19/25.
//

import Foundation

struct FullPLLAlgorithms {
    static let algorithms: [Algorithm] = [
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
        Algorithm(name: "Rb", algorithm: "(R' U2 R) U2 R' F (R U R' U') gR' F' R2 U'", note: "2 times")
    ]
}
