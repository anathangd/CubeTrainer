//
//  SolveCountButton.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 8/24/25.
//

import Foundation
import SwiftUI
import WatchConnectivity

struct SolveCountButton: View {
    @EnvironmentObject var connectivity: PhoneConnectivity
    @EnvironmentObject var model: SolveCountModel
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
                            if WCSession.default.isReachable {
                                let solveCount = model.count
                                WCSession.default.sendMessage(["solveCount": solveCount]) { response in
                                    print("✅ Watch responded: \(response)")
                                } errorHandler: { error in
                                    print("❌ Failed to send message: \(error.localizedDescription)")
                                }
                            } else {
                                print("⚠️ Watch not reachable right now, queuing solve count update.")
                                WCSession.default.transferUserInfo(["solveCount": model.count])
                            }
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
                                    if WCSession.default.isReachable {
                                        let solveCount = model.count
                                        WCSession.default.sendMessage(["solveCount": solveCount]) { response in
                                            print("✅ Watch responded: \(response)")
                                        } errorHandler: { error in
                                            print("❌ Failed to send message: \(error.localizedDescription)")
                                        }
                                    } else {
                                        print("⚠️ Watch not reachable right now, queuing solve count update.")
                                        WCSession.default.transferUserInfo(["solveCount": model.count])
                                    }
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
                            .contentShape(Rectangle())
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
        .onAppear {
            if WCSession.default.isReachable {
                let solveCount = model.count
                WCSession.default.sendMessage(["solveCount": solveCount]) { response in
                    print("✅ Watch responded: \(response)")
                } errorHandler: { error in
                    print("❌ Failed to send message: \(error.localizedDescription)")
                }
            } else {
                print("⚠️ Watch not reachable right now")
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
