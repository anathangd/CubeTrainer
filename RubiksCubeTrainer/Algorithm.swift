//
//  Algorithm.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 2025-03-20.
//

import Foundation

struct Algorithm: Identifiable, Codable {
    var id = UUID()
    var name: String
    var algorithm: String
    var note: String
    var hasVid: Bool = false
    var seen: Bool = false
    var answer: String = ""
}

struct Category {
    var name: String
    var algorithms: [Algorithm]
}
