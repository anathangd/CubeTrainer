//
//  SolveCountButton.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 8/24/25.
//

import Foundation
import SwiftUI

struct SolveCountButton: View {
    @ObservedObject var model: SolveCountModel
    @Binding var editCount: Bool

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        ZStack {
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.blue)
                            Text(String(model.count))
                                .foregroundStyle(.white)
                                .font(.caption)
                        }
                        // .padding(.top, 15)
                        .padding(.trailing, 10)
                        .onTapGesture {
                            model.count += 1
                            editCount = false
                        }
                        .sensoryFeedback(.increase, trigger: model.count)
                        .sensoryFeedback(.impact(weight: .heavy), trigger: model.count)
                        .sensoryFeedback(.increase, trigger: editCount)
                        .sensoryFeedback(.impact(weight: .heavy), trigger: editCount)
                        .onLongPressGesture {
                            editCount.toggle()
                        }
                        if editCount {
                            Button {
                                if model.count > 0 {
                                    model.count -= 1
                                    if model.count == 0 {
                                        editCount = false
                                    }
                                } else {
                                    editCount = false
                                }
                            } label: {
                                Text("-")
                            }
                            .frame(width: 35, height: 30)
                            .foregroundStyle(.white)
                            .background(model.count != 0 ? .blue : .gray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.top, 5)
                            .padding(.trailing, 10)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

class SolveCountModel: ObservableObject {
    @Published var count: Int {
        didSet {
            UserDefaults.standard.set(count, forKey: "solveCount")
        }
    }

    init() {
        self.count = UserDefaults.standard.integer(forKey: "solveCount")
    }
}
