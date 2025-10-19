//
//  F2LAlgorithms.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 10/19/25.
//

import Foundation

struct F2LAlgorithms {
    static let algorithms: [Algorithm] = [
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
        Algorithm(name: "corner bottom edge middle 5", algorithm: "(R U' R' d R' U2 R) (U R' U2 R)", note: "", hasVid: true)
    ]
}
