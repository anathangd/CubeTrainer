//
//  SolveTime.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 2025-05-15.
//

import Foundation
import SwiftData

@Model
class SolveTime {
    var solveTime: TimeInterval
    var memo: String
    var date: Date

    init(solveTime: TimeInterval, memo: String, date: Date = .now) {
        self.solveTime = solveTime
        self.memo = memo
        self.date = date
    }
}
