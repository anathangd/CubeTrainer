//
//  CFOPSolveTime.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 2025-06-14.
//

import Foundation
import SwiftData

@Model
class CFOPSolveTime {
    var crossSolveTime: TimeInterval
    var f2LSolveTime: TimeInterval
    var ollSolveTime: TimeInterval
    var pllSolveTime: TimeInterval
    var memo: String
    var date: Date

    init(crossSolveTime: TimeInterval, f2LSolveTime: TimeInterval, ollSolveTime: TimeInterval, pllSolveTime: TimeInterval, memo: String, date: Date = .now) {
        self.crossSolveTime = crossSolveTime
        self.f2LSolveTime = f2LSolveTime
        self.ollSolveTime = ollSolveTime
        self.pllSolveTime = pllSolveTime
        self.memo = memo
        self.date = date
    }
}
