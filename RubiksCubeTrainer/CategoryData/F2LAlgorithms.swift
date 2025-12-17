//
//  F2LAlgorithms.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 10/19/25.
//

import Foundation

struct F2LAlgorithms {
    static let algorithms: [Algorithm] = [
        Algorithm(name: "corner edge top 1", algorithm: "(U' R U' R') (U R U R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 2", algorithm: "d (R' U R) (U' R' U' R)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 3", algorithm: "(U' R U R') (U R U R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 4", algorithm: "(U' R U' R') U (b' R' b)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 5", algorithm: "d (R' U2' R U') (f R f')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 6", algorithm: "(U' R U2' R') U (b' R' b)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 7", algorithm: "(R U' R') U2 (b' R' b)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 8", algorithm: "(R U R' U2') (R U' R' U R U' R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 9", algorithm: "d (R' U2' R U R' U2' R)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 10", algorithm: "(R U R') U (R U' R' U R U' R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 11", algorithm: "d (R' U' R U R' U2' R)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner edge top 12", algorithm: "(U' R U R') (U' R U2' R')", note: "", hasVid: true, roofpig: true),
        
        Algorithm(name: "corner up edge top 1", algorithm: "(R U2' R') (U' R U R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner up edge top 2", algorithm: "y (L' U2 L) (U L' U' L)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner up edge top 3", algorithm: "U (R U2' R' U R U' R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner up edge top 4", algorithm: "d' (L' U2 L U' L' U L)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner up edge top 5", algorithm: "U2' (R U R') (U R U' R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner up edge top 6", algorithm: "d' U' (L' U' L) (U' L' U L)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner up edge top 7", algorithm: "U (R U' R' U' R U' R') (U R U' R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner up edge top 8", algorithm: "d' (L' U L U L' U L) (U' L' U L)", note: "", hasVid: true, roofpig: true),
        
        Algorithm(name: "corner top edge middle 1", algorithm: "(U' R U2' R') (U R U R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner top edge middle 2", algorithm: "(U' R U' R' U') (R U2' R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner top edge middle 3", algorithm: "d (R' U' R U') (f R f')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner top edge middle 4", algorithm: "(U' R U R') U (b' R' b)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner top edge middle 5", algorithm: "(R U' R') U (b' R b)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner top edge middle 6", algorithm: "(R U R' U') (R U R' U') (R U R')", note: "", hasVid: true, roofpig: true),
        
        Algorithm(name: "corner bottom edge top 1", algorithm: "(U R U' R') U (b' R b)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner bottom edge top 2", algorithm: "U' (R' F R F') (R U R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner bottom edge top 3", algorithm: "U' (R U R' U' R U R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner bottom edge top 4", algorithm: "(R U' R' U R U' R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner bottom edge top 5", algorithm: "(R U R' U') (R U R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner bottom edge top 6", algorithm: "(R' F R F') (U R U' R')", note: "", hasVid: true, roofpig: true),
        
        Algorithm(name: "corner bottom edge middle 1", algorithm: "(R U' R' U) R U2' R' (U R U' R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner bottom edge middle 2", algorithm: "(R U' R' U' R U R') (U' R U2' R')", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner bottom edge middle 3", algorithm: "(R U R') (U' R U' R') U2 (b' R' b)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner bottom edge middle 4", algorithm: "(R U R' U') d' (L' U L U L' U L U' L' U L)", note: "", hasVid: true, roofpig: true),
        Algorithm(name: "corner bottom edge middle 5", algorithm: "(R U' R') d (R' U2' R U R' U2' R)", note: "", hasVid: true, roofpig: true)
    ]
}
