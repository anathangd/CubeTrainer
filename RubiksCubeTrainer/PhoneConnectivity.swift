//
//  PhoneConnectivity.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 9/29/25.
//

import Foundation
import WatchConnectivity
import SwiftUI

class PhoneConnectivity: NSObject, WCSessionDelegate, ObservableObject {
    weak var solveCountModel: SolveCountModel?
    
    init(solveCountModel: SolveCountModel) {
        print("PhoneConnectivity init with model: \(String(describing: solveCountModel))")
        self.solveCountModel = solveCountModel
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            print("Setting WCSession delegate to PhoneConnectivity")
            session.activate()
        }
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
                try? session.updateApplicationContext(["solveCount": currentCount])
            } else {
                print("⚠️ Unrecognized message: \(message)")
            }
        }
    }
    
    // MARK: - WCSessionDelegate
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Phone session activated, delegate: \(String(describing: session.delegate))")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        // required by protocol but no action needed
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // required by protocol but no action needed
    }
}
