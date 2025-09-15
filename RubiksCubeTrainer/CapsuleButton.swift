//
//  CapsuleButton.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 7/12/25.
//

import Foundation
import SwiftUI

struct CapsuleButton: View {
    let title: String
    var color: Color = .blue
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
        }
        .padding(20)
        .background(color)
        .foregroundColor(.white)
        .clipShape(Capsule())
        .padding(10)
    }
}

extension View {
    func capsuleButtonStyle(color: Color = .blue) -> some View {
        self
            .padding(20)
            .background(color)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding(10)
    }
}
