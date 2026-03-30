//
//  ContentView.swift
//  RubiksCubeTrainerWatch Watch App
//
//  Created by Nathan Davis on 9/29/25.
//

import SwiftUI
import WatchConnectivity
import WatchKit

struct ContentView: View {
    @ObservedObject private var watchManager = WatchConnectivityManager.shared
    //    var isConnected: Bool {
    //        WCSession.default.isReachable
    //    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundStyle(.yellow)
                //            VStack {
                //                HStack {
                //                    Spacer()
                //                    Text(isConnected ? "✅" : "⚠️")
                //                        .font(.footnote)
                //                        .padding(.horizontal, 10)
                //                }
                //                Spacer()
                //            }
                VStack {
                    HStack {
                        NavigationLink(destination: PLLRecView()) {
                            Text("PLL")
                                .padding(.horizontal)
                                .background(.blue)
                                .clipShape(Capsule())
                                .padding()
                        }
                        .buttonStyle(.plain)
                        Spacer()
                    }
                    Spacer()
                }
                .ignoresSafeArea()
                VStack {
                    Spacer()
                    Button(action: {
                        watchManager.incrementSolve()
                        WKInterfaceDevice.current().play(.directionUp)
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 40))
                            .padding(20)
                            .padding(.horizontal, 40)
                            .background(.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .padding(.bottom, -10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                VStack(spacing: 10) {
                    Text("\(watchManager.solveCount)")
                        .font(.system(size: 60))
                        .foregroundStyle(.black)
                        .padding(.bottom, 65)
                }
                .padding()
                .onAppear {
                    print("requesting solve count")
                    watchManager.requestCurrentSolveCount()
                }
            }
        }
    }
}
    
    #Preview {
        ContentView()
    }
