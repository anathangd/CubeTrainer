//
//  OLLRecognitionCases.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 10/19/25.
//

import Foundation

struct OLLRecognitionCases {
    static let cases: [Algorithm] = [
        // crosses
        Algorithm(name: "fish1", algorithm: "(No rotation) fishRight", note: "", answer: "fishRight"),
        Algorithm(name: "fish2", algorithm: "(U) fishRight", note: "", answer: "fishRight"),
        Algorithm(name: "fish3", algorithm: "(U2) fishRight", note: "", answer: "fishRight"),
        Algorithm(name: "fish4", algorithm: "(U') fishRight", note: "", answer: "fishRight"),
        Algorithm(name: "fish5", algorithm: "(No rotation) fishLeft", note: "", answer: "fishLeft"),
        Algorithm(name: "fish6", algorithm: "(U) fishLeft", note: "", answer: "fishLeft"),
        Algorithm(name: "fish7", algorithm: "(U2) fishLeft", note: "", answer: "fishLeft"),
        Algorithm(name: "fish8", algorithm: "(U') fishLeft", note: "", answer: "fishLeft"),
        
        Algorithm(name: "diagonal1", algorithm: "(No rotation) diagonalLeft", note: "", answer: "diagonalLeft"),
        Algorithm(name: "diagonal2", algorithm: "(No rotation) diagonalLeftMirrored", note: "", answer: "diagonalLeftMirrored"),
        Algorithm(name: "diagonal3", algorithm: "(U) diagonalLeftMirrored", note: "", answer: "diagonalLeftMirrored"),
        Algorithm(name: "diagonal4", algorithm: "(U') diagonalLeft", note: "", answer: "diagonalLeft"),
        
        Algorithm(name: "Tout901", algorithm: "(No rotation) Tout90", note: "", answer: "Tout90"),
        Algorithm(name: "Tout902", algorithm: "(U) Tout90", note: "", answer: "Tout90"),
        Algorithm(name: "Tout903", algorithm: "(No rotation) Tout90Mirrored", note: "", answer: "Tout90Mirrored"),
        Algorithm(name: "Tout904", algorithm: "(U') Tout90", note: "", answer: "Tout90"),
        
        Algorithm(name: "crossMan901", algorithm: "(No rotation) crossMan90", note: "", answer: "crossMan90"),
        Algorithm(name: "crossMan902", algorithm: "(U) crossMan90", note: "", answer: "crossMan90"),
        Algorithm(name: "crossMan903", algorithm: "(No rotation) crossMan90Mirrored", note: "", answer: "crossMan90Mirrored"),
        Algorithm(name: "crossMan904", algorithm: "(U') crossMan90", note: "", answer: "crossMan90"),
        
        Algorithm(name: "cross1", algorithm: "(No rotation) cross", note: "", answer: "cross"),
        Algorithm(name: "cross2", algorithm: "(U) cross", note: "", answer: "cross"),
        
        Algorithm(name: "Tdown1", algorithm: "(No rotation) Tdown", note: "", answer: "Tdown"),
        Algorithm(name: "Tdown2", algorithm: "(U) Tdown", note: "", answer: "Tdown"),
        Algorithm(name: "Tdown3", algorithm: "(U2) Tdown", note: "", answer: "Tdown"),
        Algorithm(name: "Tdown4", algorithm: "(U') Tdown", note: "", answer: "Tdown"),
        
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
        // dots 5
        Algorithm(name: "dotsrec15", algorithm: "(No rotation) dots 5", note: "", answer: "dots 5"),
        Algorithm(name: "dotsrec16", algorithm: "(U) dots 5", note: "", answer: "dots 5"),
        Algorithm(name: "dotsrec17", algorithm: "(U2) dots 5", note: "", answer: "dots 5"),
        Algorithm(name: "dotsrec18", algorithm: "(U') dots 5", note: "", answer: "dots 5"),
        // dots 6
        Algorithm(name: "dotsrec19", algorithm: "(No rotation) dots 6", note: "", answer: "dots 6"),
        Algorithm(name: "dotsrec20", algorithm: "(U) dots 6", note: "", answer: "dots 6"),
        Algorithm(name: "dotsrec21", algorithm: "(U2) dots 6", note: "", answer: "dots 6"),
        Algorithm(name: "dotsrec22", algorithm: "(U') dots 6", note: "", answer: "dots 6"),
        // dots 7
        Algorithm(name: "dotsrec23", algorithm: "(No rotation) dots 7", note: "", answer: "dots 7"),
        Algorithm(name: "dotsrec24", algorithm: "(U) dots 7", note: "", answer: "dots 7"),
        Algorithm(name: "dotsrec25", algorithm: "(U') dots 7 mirrored", note: "", answer: "dots 7 mirrored"),
        Algorithm(name: "dotsrec26", algorithm: "(No rotation) dots 7 mirrored", note: "", answer: "dots 7 mirrored"),
        // dots 8
        Algorithm(name: "dotsrec27", algorithm: "(No rotation) dots 8", note: "", answer: "dots 8"),
        
        // All Corners
        Algorithm(name: "allcornersrec1", algorithm: "(No rotation) all corners 1", note: "", answer: "all corners 1"),
        Algorithm(name: "allcornersrec2", algorithm: "(U) all corners 1", note: "", answer: "all corners 1"),
        Algorithm(name: "allcornersrec3", algorithm: "(No rotation) all corners 2", note: "", answer: "all corners 2"),
        Algorithm(name: "allcornersrec4", algorithm: "(U') all corners 2", note: "", answer: "all corners 2"),
        Algorithm(name: "allcornersrec5", algorithm: "(No rotation) all corners 2 mirrored", note: "", answer: "all corners 2 mirrored"),
        Algorithm(name: "allcornersrec6", algorithm: "(U) all corners 2 mirrored", note: "", answer: "all corners 2 mirrored"),
        
        // Lines
        // line 1
        Algorithm(name: "linesrec1", algorithm: "(No rotation) line 1", note: "", answer: "line 1"),
        Algorithm(name: "linesrec2", algorithm: "(U) line 1", note: "", answer: "line 1"),
        // line 2
        Algorithm(name: "linesrec3", algorithm: "(No rotation) line 2", note: "", answer: "line 2"),
        Algorithm(name: "linesrec4", algorithm: "(U) line 2", note: "", answer: "line 2"),
        Algorithm(name: "linesrec5", algorithm: "(No rotation) line 2 mirrored", note: "", answer: "line 2 mirrored"),
        Algorithm(name: "linesrec6", algorithm: "(U') line 2", note: "", answer: "line 2"),
        // line 3
        Algorithm(name: "linesrec7", algorithm: "(No rotation) line 3", note: "", answer: "line 3"),
        Algorithm(name: "linesrec8", algorithm: "(U) line 3", note: "", answer: "line 3"),
        Algorithm(name: "linesrec9", algorithm: "(No rotation) line 3 mirrored", note: "", answer: "line 3 mirrored"),
        Algorithm(name: "linesrec10", algorithm: "(U') line 3", note: "", answer: "line 3"),
        // line 4
        Algorithm(name: "linesrec11", algorithm: "(No rotation) line 4", note: "", answer: "line 4"),
        Algorithm(name: "linesrec12", algorithm: "(U) line 4", note: "", answer: "line 4"),
        
        // Ts
        // T1
        Algorithm(name: "Trec1", algorithm: "(No rotation) T1", note: "", answer: "T1"),
        Algorithm(name: "Trec2", algorithm: "(U) T1", note: "", answer: "T1"),
        Algorithm(name: "Trec3", algorithm: "(No rotation) T1 mirrored", note: "", answer: "T1 mirrored"),
        Algorithm(name: "Trec4", algorithm: "(U') T1", note: "", answer: "T1"),
        // T2
        Algorithm(name: "Trec5", algorithm: "(No rotation) T2", note: "", answer: "T2"),
        Algorithm(name: "Trec6", algorithm: "(U) T2", note: "", answer: "T2"),
        Algorithm(name: "Trec7", algorithm: "(No rotation) T2 mirrored", note: "", answer: "T2 mirrored"),
        Algorithm(name: "Trec8", algorithm: "(U') T2", note: "", answer: "T2"),
        
        // Zs
        // Z1
        Algorithm(name: "zrec1", algorithm: "(No rotation) Z1", note: "", answer: "Z1"),
        Algorithm(name: "zrec2", algorithm: "(U) Z1", note: "", answer: "Z1"),
        Algorithm(name: "zrec3", algorithm: "(U2) Z1", note: "", answer: "Z1"),
        Algorithm(name: "zrec4", algorithm: "(U') Z1", note: "", answer: "Z1"),
        // Z2
        Algorithm(name: "zrec5", algorithm: "(No rotation) Z2", note: "", answer: "Z2"),
        Algorithm(name: "zrec6", algorithm: "(U) Z2", note: "", answer: "Z2"),
        Algorithm(name: "zrec7", algorithm: "(U2) Z2", note: "", answer: "Z2"),
        Algorithm(name: "zrec8", algorithm: "(U') Z2", note: "", answer: "Z2"),
        
        // Big Ls
        // L1
        Algorithm(name: "Lrec1", algorithm: "(No rotation) L1", note: "", answer: "L1"),
        Algorithm(name: "Lrec2", algorithm: "(U) L1", note: "", answer: "L1"),
        Algorithm(name: "Lrec3", algorithm: "(U2) L1", note: "", answer: "L1"),
        Algorithm(name: "Lrec4", algorithm: "(U') L1", note: "", answer: "L1"),
        // L2
        Algorithm(name: "Lrec5", algorithm: "(No rotation) L2", note: "", answer: "L2"),
        Algorithm(name: "Lrec6", algorithm: "(U) L2", note: "", answer: "L2"),
        Algorithm(name: "Lrec7", algorithm: "(U2) L2", note: "", answer: "L2"),
        Algorithm(name: "Lrec8", algorithm: "(U') L2", note: "", answer: "L2"),
        // L3
        Algorithm(name: "Lrec9", algorithm: "(No rotation) L3", note: "", answer: "L3"),
        Algorithm(name: "Lrec10", algorithm: "(U) L3", note: "", answer: "L3"),
        Algorithm(name: "Lrec11", algorithm: "(U2) L3", note: "", answer: "L3"),
        Algorithm(name: "Lrec12", algorithm: "(U') L3", note: "", answer: "L3"),
        // L4
        Algorithm(name: "Lrec13", algorithm: "(No rotation) L4", note: "", answer: "L4"),
        Algorithm(name: "Lrec14", algorithm: "(U) L4", note: "", answer: "L4"),
        Algorithm(name: "Lrec15", algorithm: "(U2) L4", note: "", answer: "L4"),
        Algorithm(name: "Lrec16", algorithm: "(U') L4", note: "", answer: "L4"),
        
        // Cs
        // C1
        Algorithm(name: "Crec1", algorithm: "(No rotation) C1", note: "", answer: "C1"),
        Algorithm(name: "Crec2", algorithm: "(U) C1", note: "", answer: "C1"),
        Algorithm(name: "Crec3", algorithm: "(No rotation) C1 mirrored", note: "", answer: "C1 mirrored"),
        Algorithm(name: "Crec4", algorithm: "(U') C1", note: "", answer: "C1"),
        // C2
        Algorithm(name: "Crec5", algorithm: "(No rotation) C2", note: "", answer: "C2"),
        Algorithm(name: "Crec6", algorithm: "(U) C2", note: "", answer: "C2"),
        Algorithm(name: "Crec7", algorithm: "(U2) C2", note: "", answer: "C2"),
        Algorithm(name: "Crec8", algorithm: "(U') C2", note: "", answer: "C2"),
        
        // Ws
        // W1
        Algorithm(name: "Wrec1", algorithm: "(No rotation) W1", note: "", answer: "W1"),
        Algorithm(name: "Wrec2", algorithm: "(U) W1", note: "", answer: "W1"),
        Algorithm(name: "Wrec3", algorithm: "(U2) W1 (faces front)", note: "", answer: "W1"),
        Algorithm(name: "Wrec4", algorithm: "(U') W1", note: "", answer: "W1"),
        // W2
        Algorithm(name: "Wrec5", algorithm: "(No rotation) W2", note: "", answer: "W2"),
        Algorithm(name: "Wrec6", algorithm: "(U) W2", note: "", answer: "W2"),
        Algorithm(name: "Wrec7", algorithm: "(U2) W2", note: "", answer: "W2"),
        Algorithm(name: "Wrec8", algorithm: "(U') W2 (faces right)", note: "", answer: "W2"),
        
        // Ps
        // P1
        Algorithm(name: "Prec1", algorithm: "(No rotation) P1", note: "", answer: "P1"),
        Algorithm(name: "Prec2", algorithm: "(U) P1", note: "", answer: "P1"),
        Algorithm(name: "Prec3", algorithm: "(U2) P1", note: "", answer: "P1"),
        Algorithm(name: "Prec4", algorithm: "(U') P1", note: "", answer: "P1"),
        // P2
        Algorithm(name: "Prec5", algorithm: "(No rotation) P2", note: "", answer: "P2"),
        Algorithm(name: "Prec6", algorithm: "(U) P2", note: "", answer: "P2"),
        Algorithm(name: "Prec7", algorithm: "(U2) P2", note: "", answer: "P2"),
        Algorithm(name: "Prec8", algorithm: "(U') P2", note: "", answer: "P2"),
        // P3
        Algorithm(name: "Prec9", algorithm: "(No rotation) P3", note: "", answer: "P3"),
        Algorithm(name: "Prec10", algorithm: "(U) P3", note: "", answer: "P3"),
        Algorithm(name: "Prec11", algorithm: "(U2) P3", note: "", answer: "P3"),
        Algorithm(name: "Prec12", algorithm: "(U') P3", note: "", answer: "P3"),
        // P4
        Algorithm(name: "Prec13", algorithm: "(No rotation) P4", note: "", answer: "P4"),
        Algorithm(name: "Prec14", algorithm: "(U) P4", note: "", answer: "P4"),
        Algorithm(name: "Prec15", algorithm: "(U2) P4", note: "", answer: "P4"),
        Algorithm(name: "Prec16", algorithm: "(U') P4", note: "", answer: "P4"),
        
        // Squares
        // square 1
        Algorithm(name: "squarerec1", algorithm: "(No rotation) square 1", note: "", answer: "square 1"),
        Algorithm(name: "squarerec2", algorithm: "(U) square 1", note: "", answer: "square 1"),
        Algorithm(name: "squarerec3", algorithm: "(U') square 1 mirrored", note: "", answer: "square 1 mirrored"),
        Algorithm(name: "squarerec4", algorithm: "(No rotation) square 1 mirrored", note: "", answer: "square 1 mirrored"),
        // square 2
        Algorithm(name: "squarerec5", algorithm: "(No rotation) square 2", note: "", answer: "square 2"),
        Algorithm(name: "squarerec6", algorithm: "(U) square 2", note: "", answer: "square 2"),
        Algorithm(name: "squarerec7", algorithm: "(U') square 2 mirrored", note: "", answer: "square 2 mirrored"),
        Algorithm(name: "squarerec8", algorithm: "(No rotation) square 2 mirrored", note: "", answer: "square 2 mirrored"),
        // square 3
        Algorithm(name: "squarerec9", algorithm: "(No rotation) square 3", note: "", answer: "square 3"),
        Algorithm(name: "squarerec10", algorithm: "(U) square 3", note: "", answer: "square 3"),
        Algorithm(name: "squarerec11", algorithm: "(U2) square 3", note: "", answer: "square 3"),
        Algorithm(name: "squarerec12", algorithm: "(U') square 3", note: "", answer: "square 3"),
        // square 4
        Algorithm(name: "squarerec13", algorithm: "(No rotation) square 4", note: "", answer: "square 4"),
        Algorithm(name: "squarerec14", algorithm: "(U) square 4", note: "", answer: "square 4"),
        Algorithm(name: "squarerec15", algorithm: "(U2) square 4", note: "", answer: "square 4"),
        Algorithm(name: "squarerec16", algorithm: "(U') square 4", note: "", answer: "square 4"),
        
        // Little Ls
        // littleL1
        Algorithm(name: "littleLrec1", algorithm: "(No rotation) littleL1", note: "", answer: "littleL1"),
        Algorithm(name: "littleLrec2", algorithm: "(U) littleL1", note: "", answer: "littleL1"),
        Algorithm(name: "littleLrec3", algorithm: "(U2) littleL1 (yellow headlights)", note: "", answer: "littleL1"),
        Algorithm(name: "littleLrec4", algorithm: "(U') littleL1", note: "", answer: "littleL1"),
        // littleL2
        Algorithm(name: "littleLrec5", algorithm: "(No rotation) littleL2", note: "", answer: "littleL2"),
        Algorithm(name: "littleLrec6", algorithm: "(U) littleL2", note: "", answer: "littleL2"),
        Algorithm(name: "littleLrec7", algorithm: "(U2) littleL2", note: "", answer: "littleL2"),
        Algorithm(name: "littleLrec8", algorithm: "(U') littleL2 (yellow headlights)", note: "", answer: "littleL2"),
        // littleL3
        Algorithm(name: "littleLrec9", algorithm: "(No rotation) littleL3", note: "", answer: "littleL3"),
        Algorithm(name: "littleLrec10", algorithm: "(U) littleL3", note: "", answer: "littleL3"),
        Algorithm(name: "littleLrec11", algorithm: "(U2) littleL3 (faces front)", note: "", answer: "littleL3"),
        Algorithm(name: "littleLrec12", algorithm: "(U') littleL3", note: "", answer: "littleL3"),
        // littleL4
        Algorithm(name: "littleLrec13", algorithm: "(No rotation) littleL4", note: "", answer: "littleL4"),
        Algorithm(name: "littleLrec14", algorithm: "(U) littleL4", note: "", answer: "littleL4"),
        Algorithm(name: "littleLrec15", algorithm: "(U2) littleL4", note: "", answer: "littleL4"),
        Algorithm(name: "littleLrec16", algorithm: "(U') littleL4 (faces right)", note: "", answer: "littleL4"),
        // littleL5
        Algorithm(name: "littleLrec17", algorithm: "(No rotation) littleL5", note: "", answer: "littleL5"),
        Algorithm(name: "littleLrec18", algorithm: "(U) littleL5 (checkered, three on the backside)", note: "", answer: "littleL5"),
        Algorithm(name: "littleLrec19", algorithm: "(U2) littleL5 (only headlights)", note: "", answer: "littleL5"),
        Algorithm(name: "littleLrec20", algorithm: "(U') littleL5 (only line)", note: "", answer: "littleL5"),
        // littleL6
        Algorithm(name: "littleLrec21", algorithm: "(No rotation) littleL6 (checkered, three on the backside)", note: "", answer: "littleL6"),
        Algorithm(name: "littleLrec22", algorithm: "(U) littleL6", note: "", answer: "littleL6"),
        Algorithm(name: "littleLrec23", algorithm: "(U2) littleL6 (only line)", note: "", answer: "littleL6"),
        Algorithm(name: "littleLrec24", algorithm: "(U') littleL6 (only headlights)", note: "", answer: "littleL6"),
        
        // Other shapes
        // other 1
        Algorithm(name: "otherrec1", algorithm: "(No rotation) other 1", note: "", answer: "other 1"),
        Algorithm(name: "otherrec2", algorithm: "(U) other 1", note: "", answer: "other 1"),
        Algorithm(name: "otherrec3", algorithm: "(U2) other 1", note: "", answer: "other 1"),
        Algorithm(name: "otherrec4", algorithm: "(U') other 1", note: "", answer: "other 1"),
        // other 2
        Algorithm(name: "otherrec5", algorithm: "(No rotation) other 2", note: "", answer: "other 2"),
        Algorithm(name: "otherrec6", algorithm: "(U) other 2", note: "", answer: "other 2"),
        Algorithm(name: "otherrec7", algorithm: "(U2) other 2", note: "", answer: "other 2"),
        Algorithm(name: "otherrec8", algorithm: "(U') other 2", note: "", answer: "other 2"),
        // other 3
        Algorithm(name: "otherrec9", algorithm: "(No rotation) other 3", note: "", answer: "other 3"),
        Algorithm(name: "otherrec10", algorithm: "(U) other 3", note: "", answer: "other 3"),
        Algorithm(name: "otherrec11", algorithm: "(U2) other 3", note: "", answer: "other 3"),
        Algorithm(name: "otherrec12", algorithm: "(U') other 3", note: "", answer: "other 3"),
        // other 4
        Algorithm(name: "otherrec13", algorithm: "(No rotation) other 4", note: "", answer: "other 4"),
        Algorithm(name: "otherrec14", algorithm: "(U) other 4", note: "", answer: "other 4"),
        Algorithm(name: "otherrec15", algorithm: "(U2) other 4", note: "", answer: "other 4"),
        Algorithm(name: "otherrec16", algorithm: "(U') other 4", note: "", answer: "other 4"),
        // other 5
        Algorithm(name: "otherrec17", algorithm: "(No rotation) other 5", note: "", answer: "other 5"),
        Algorithm(name: "otherrec18", algorithm: "(U) other 5", note: "", answer: "other 5"),
        Algorithm(name: "otherrec19", algorithm: "(U2) other 5", note: "", answer: "other 5"),
        Algorithm(name: "otherrec20", algorithm: "(U') other 5", note: "", answer: "other 5"),
        // other 6
        Algorithm(name: "otherrec21", algorithm: "(No rotation) other 6", note: "", answer: "other 6"),
        Algorithm(name: "otherrec22", algorithm: "(U) other 6", note: "", answer: "other 6"),
        Algorithm(name: "otherrec23", algorithm: "(U2) other 6", note: "", answer: "other 6"),
        Algorithm(name: "otherrec24", algorithm: "(U') other 6", note: "", answer: "other 6"),
        // other 7
        Algorithm(name: "otherrec25", algorithm: "(No rotation) other 7", note: "", answer: "other 7"),
        Algorithm(name: "otherrec26", algorithm: "(U) other 7", note: "", answer: "other 7"),
        Algorithm(name: "otherrec27", algorithm: "(U2) other 7", note: "", answer: "other 7"),
        Algorithm(name: "otherrec28", algorithm: "(U') other 7", note: "", answer: "other 7"),
        // other 9
        Algorithm(name: "otherrec29", algorithm: "(No rotation) other 9", note: "", answer: "other 9"),
        Algorithm(name: "otherrec30", algorithm: "(U) other 9", note: "", answer: "other 9"),
        Algorithm(name: "otherrec31", algorithm: "(U2) other 9", note: "", answer: "other 9"),
        Algorithm(name: "otherrec32", algorithm: "(U') other 9", note: "", answer: "other 9"),
        // other 10
        Algorithm(name: "otherrec33", algorithm: "(No rotation) other 10", note: "", answer: "other 10"),
        Algorithm(name: "otherrec34", algorithm: "(U) other 10", note: "", answer: "other 10"),
        Algorithm(name: "otherrec35", algorithm: "(U2) other 10", note: "", answer: "other 10"),
        Algorithm(name: "otherrec36", algorithm: "(U') other 10", note: "", answer: "other 10"),
        // other 8
        Algorithm(name: "otherrec37", algorithm: "(No rotation) other 8", note: "", answer: "other 8"),
        Algorithm(name: "otherrec38", algorithm: "(U) other 8", note: "", answer: "other 8"),
        Algorithm(name: "otherrec39", algorithm: "(U2) other 8", note: "", answer: "other 8"),
        Algorithm(name: "otherrec40", algorithm: "(U') other 8", note: "", answer: "other 8"),
    ]
}

struct OLLRecognitionCasesAbridged {
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
