//
//  Algorithm.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 2025-03-20.
//

import Foundation

struct Algorithm: Identifiable {
    let id = UUID()
    var name: String
    var algorithm: String
    var note: String
    var hasVid: Bool = false
}

struct Category {
    var name: String
    var algorithms: [Algorithm]
}
