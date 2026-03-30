//
//  WatchConnectivity.swift
//  RubiksCubeTrainerWatch Watch App
//
//  Created by Nathan Davis on 9/29/25.
//

import Foundation
import WatchConnectivity
import SwiftUI
import Combine

class WatchConnectivityManager: NSObject, ObservableObject, WCSessionDelegate {
    static let shared = WatchConnectivityManager()
    
    @Published var solveCount: Int = UserDefaults.standard.integer(forKey: "solveCount")
    
    private override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            print("WatchConnectivityManager initialized and session activated")
        }
    }
    
    // Increment solve from watch using background-safe transfer
    func incrementSolve() {
        self.solveCount += 1 // locally update UI immediately
        UserDefaults.standard.set(solveCount, forKey: "solveCount")
        print("incrementSolve called, local solveCount: \(solveCount)")
        
        
        // Queue increment to phone for delivery even if app is asleep
        WCSession.default.transferUserInfo(["incrementSolve": 1])
        print("transferUserInfo sent: incrementSolve = 1")
    }
    
    // MARK: WCSessionDelegate
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async {
            if let count = applicationContext["solveCount"] as? Int {
                self.solveCount = count
                UserDefaults.standard.set(self.solveCount, forKey: "solveCount")
                print("didReceiveApplicationContext received, solveCount updated to \(self.solveCount)")
            } else {
                print("didReceiveApplicationContext received but no solveCount found")
            }
        }
    }
    
    func session(_ session: WCSession,
                 didReceiveMessage message: [String : Any],
                 replyHandler: @escaping ([String : Any]) -> Void) {
        var messageToSend = ""
        DispatchQueue.main.async {
            if let count = message["solveCount"] as? Int {
                self.solveCount = count
                UserDefaults.standard.set(self.solveCount, forKey: "solveCount")
                print("📥 Watch got count \(count)")
                messageToSend = "Received count: \(count)"
            }
            replyHandler(["received message": messageToSend])
        }
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        DispatchQueue.main.async {
            if let increment = userInfo["incrementSolve"] as? Int {
                self.solveCount += increment
                UserDefaults.standard.set(self.solveCount, forKey: "solveCount")
                print("didReceiveUserInfo received, increment: \(increment), new solveCount: \(self.solveCount)")
            } else if let count = userInfo["solveCount"] as? Int {
                self.solveCount = count
                UserDefaults.standard.set(self.solveCount, forKey: "solveCount")
                print("📥 Received full solveCount: \(count)")
            } else if let _ = userInfo["requestSolveCount"] as? Bool {
                print("didReceiveUserInfo received requestSolveCount")
            } else {
                print("didReceiveUserInfo received unrecognized data: \(userInfo)")
            }
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Watch session activated with state: \(activationState.rawValue), error: \(String(describing: error))")
    }
    
    // Request current solve count from phone safely
    func requestCurrentSolveCount() {
        print("requestCurrentSolveCount called")
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(["requestSolveCount": true]) { response in
                if let count = response["solveCount"] as? Int {
                    DispatchQueue.main.async {
                        self.solveCount = count
                        UserDefaults.standard.set(count, forKey: "solveCount")
                        print("📥 Watch got solveCount reply: \(count)")
                    }
                }
            } errorHandler: { error in
                print("❌ requestSolveCount sendMessage failed: \(error.localizedDescription)")
                WCSession.default.transferUserInfo(["requestSolveCount": true])
            }
        } else {
            // Queue request to phone; delivered when phone wakes.
            WCSession.default.transferUserInfo(["requestSolveCount": true])
            print("transferUserInfo sent: requestSolveCount = true")
        }
    }
}
