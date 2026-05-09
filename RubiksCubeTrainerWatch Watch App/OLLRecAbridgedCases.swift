//
//  OLLRecAbridgedCases.swift
//  RubiksCubeTrainerWatch Watch App
//
//  Created by Nathan Davis on 5/8/26.
//

import Foundation

struct OLLRecAbridgedCases {
    static let cases: [Algorithm] = [
        // crosses
        Algorithm(name: "diagonal1", algorithm: "(No rotation) diagonalLeft", note: "", answer: "diagonalLeft"),
        Algorithm(name: "diagonal2", algorithm: "(No rotation) diagonalLeftMirrored", note: "", answer: "diagonalLeftMirrored"),
        Algorithm(name: "diagonal3", algorithm: "(U) diagonalLeftMirrored", note: "", answer: "diagonalLeftMirrored"),
        Algorithm(name: "diagonal4", algorithm: "(U') diagonalLeft", note: "", answer: "diagonalLeft"),
        
        // dots
        // dots 1
        Algorithm(name: "dotsrec1", algorithm: "(No rotation) dots 1", note: "", answer: "dots 1"),
        Algorithm(name: "dotsrec2", algorithm: "(U) dots 1", note: "", answer: "dots 1"),
        // dots 2
        Algorithm(name: "dotsrec3", algorithm: "(No rotation) dots 2", note: "", answer: "dots 2"),
        Algorithm(name: "dotsrec4", algorithm: "(U) dots 2", note: "", answer: "dots 2"),
        Algorithm(name: "dotsrec5", algorithm: "(No rotation) dots 2 mirrored", note: "", answer: "dots 2 mirrored"),
        Algorithm(name: "dotsrec6", algorithm: "(U') dots 2", note: "", answer: "dots 2"),
        // dots 3
        Algorithm(name: "dotsrec7", algorithm: "(No rotation) dots 3", note: "", answer: "dots 3"),
        Algorithm(name: "dotsrec8", algorithm: "(U) dots 3", note: "", answer: "dots 3"),
        Algorithm(name: "dotsrec9", algorithm: "(No rotation) dots 4 mirrored", note: "", answer: "dots 4 mirrored"),
        Algorithm(name: "dotsrec10", algorithm: "(U') dots 3", note: "", answer: "dots 3"),
        // dots 4
        Algorithm(name: "dotsrec11", algorithm: "(No rotation) dots 4", note: "", answer: "dots 4"),
        Algorithm(name: "dotsrec12", algorithm: "(U) dots 4", note: "", answer: "dots 4"),
        Algorithm(name: "dotsrec13", algorithm: "(No rotation) dots 3 mirrored", note: "", answer: "dots 3 mirrored"),
        Algorithm(name: "dotsrec14", algorithm: "(U') dots 4", note: "", answer: "dots 4"),
        
        // line 3
        Algorithm(name: "linesrec10", algorithm: "(U') line 3", note: "", answer: "line 3"),
        
        // Ws
        // W1
        Algorithm(name: "Wrec3", algorithm: "(U2) W1 (faces front)", note: "", answer: "W1"),
        // W2
        Algorithm(name: "Wrec8", algorithm: "(U') W2 (faces right)", note: "", answer: "W2"),
        
        // Little Ls
        // littleL1
        Algorithm(name: "littleLrec3", algorithm: "(U2) littleL1 (yellow headlights)", note: "", answer: "littleL1"),
        Algorithm(name: "littleLrec4", algorithm: "(U') littleL1", note: "", answer: "littleL1"),
        // littleL2
        Algorithm(name: "littleLrec8", algorithm: "(U') littleL2 (yellow headlights)", note: "", answer: "littleL2"),
        // littleL3
        Algorithm(name: "littleLrec9", algorithm: "(No rotation) littleL3", note: "", answer: "littleL3"),
        Algorithm(name: "littleLrec10", algorithm: "(U) littleL3", note: "", answer: "littleL3"),
        // littleL5
        Algorithm(name: "littleLrec19", algorithm: "(U2) littleL5 (only headlights)", note: "", answer: "littleL5"),
        // littleL6
        Algorithm(name: "littleLrec24", algorithm: "(U') littleL6 (only headlights)", note: "", answer: "littleL6"),
        
        // Other shapes
        // other 1
        Algorithm(name: "otherrec2", algorithm: "(U) other 1", note: "", answer: "other 1"),
        Algorithm(name: "otherrec3", algorithm: "(U2) other 1", note: "", answer: "other 1"),
        // other 2
        Algorithm(name: "otherrec5", algorithm: "(No rotation) other 2", note: "", answer: "other 2"),
        Algorithm(name: "otherrec8", algorithm: "(U') other 2", note: "", answer: "other 2"),
        // other 3
        Algorithm(name: "otherrec10", algorithm: "(U) other 3", note: "", answer: "other 3"),
        Algorithm(name: "otherrec11", algorithm: "(U2) other 3", note: "", answer: "other 3"),
    ]
}
