//
//  PhoneConnectivity.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 9/29/25.
//

import Foundation
import WatchConnectivity
import SwiftUI
import Combine

class PhoneConnectivity: NSObject, WCSessionDelegate, ObservableObject {
    weak var solveCountModel: SolveCountModel?
    private var solveCountCancellable: AnyCancellable?
    
    init(solveCountModel: SolveCountModel) {
        print("PhoneConnectivity init with model: \(String(describing: solveCountModel))")
        self.solveCountModel = solveCountModel
        super.init()
        observeSolveCountChanges(from: solveCountModel)
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            print("Setting WCSession delegate to PhoneConnectivity")
            session.activate()
        }
    }

    private func observeSolveCountChanges(from model: SolveCountModel) {
        solveCountCancellable = model.$count
            .removeDuplicates()
            .sink { [weak self] newCount in
                self?.pushSolveCountToWatch(newCount)
            }
    }

    private func pushSolveCountToWatch(_ count: Int) {
        let payload = ["solveCount": count]
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(payload, replyHandler: nil) { error in
                print("❌ Failed to send solveCount message: \(error.localizedDescription)")
            }
        }

        // Always update context for latest-value sync when watch launches later.
        try? WCSession.default.updateApplicationContext(payload)
        WCSession.default.transferUserInfo(payload)
    }
    
    // MARK: - Receive increments from watch
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any]) {
        DispatchQueue.main.async {
            print("Current solveCountModel: \(String(describing: self.solveCountModel))")
            if let increment = userInfo["incrementSolve"] as? Int {
                if let model = self.solveCountModel {
                    model.count += increment
                    print("received user info, incrementing solve count to \(model.count)")
                    // send back updated count to watch
                    try? session.updateApplicationContext(["solveCount": model.count])
                } else {
                    print("solveCountModel is nil, cannot increment solve count")
                }
            } else if let _ = userInfo["requestSolveCount"] as? Bool {
                let currentCount = self.solveCountModel?.count ?? 0
                print("📥 Received requestSolveCount via userInfo, replying with \(currentCount)")
                self.pushSolveCountToWatch(currentCount)
            }
        }
    }
    
    // MARK: - Receive messages (for request current count and full solveCount updates)
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let newCount = message["solveCount"] as? Int {
                print("📥 Received full solveCount from watch: \(newCount)")
                self.solveCountModel?.count = newCount
                UserDefaults.standard.set(newCount, forKey: "solveCount")
            } else if let _ = message["requestSolveCount"] as? Bool {
                print("📥 Received requestSolveCount")
                let currentCount = self.solveCountModel?.count ?? 0
                self.pushSolveCountToWatch(currentCount)
            } else {
                print("⚠️ Unrecognized message: \(message)")
            }
        }
    }

    func session(_ session: WCSession,
                 didReceiveMessage message: [String : Any],
                 replyHandler: @escaping ([String : Any]) -> Void) {
        DispatchQueue.main.async {
            if let _ = message["requestSolveCount"] as? Bool {
                let currentCount = self.solveCountModel?.count ?? 0
                self.pushSolveCountToWatch(currentCount)
                replyHandler(["solveCount": currentCount])
            } else if let newCount = message["solveCount"] as? Int {
                self.solveCountModel?.count = newCount
                UserDefaults.standard.set(newCount, forKey: "solveCount")
                self.pushSolveCountToWatch(newCount)
                replyHandler(["solveCount": newCount])
            } else {
                replyHandler([:])
            }
        }
    }
    
    // MARK: - WCSessionDelegate
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Phone session activated, delegate: \(String(describing: session.delegate))")
        let currentCount = solveCountModel?.count ?? 0
        pushSolveCountToWatch(currentCount)
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        // required by protocol but no action needed
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // required by protocol but no action needed
    }
}
