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
    
    private let isPreview: Bool

    init(isPreview: Bool = false) {
        self.isPreview = isPreview
    }

    private var displayedSolveCount: Int {
        isPreview ? 6922 : watchManager.solveCount
    }
    
    
    var body: some View {
        GeometryReader { geo in
            let screenHeight = WKInterfaceDevice.current().screenBounds.height
            
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
                                    .padding(.leading)
                                    .padding(.vertical)
                                    .padding(.leading, screenHeight > 224 ? 10 : 0)
                            }
                            .buttonStyle(.plain)
                            NavigationLink(destination: OLLRecView()) {
                                Text("OLL")
                                    .padding(.horizontal)
                                    .background(.blue)
                                    .clipShape(Capsule())
                                    .padding(.vertical)
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
                            if !isPreview {
                                watchManager.incrementSolve()
                                WKInterfaceDevice.current().play(.directionUp)
                            }
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
                        Text("\(displayedSolveCount)")
                            .font(.system(size: 60))
                            .foregroundStyle(.black)
                            .padding(.bottom, 65)
                    }
                    .padding()
                    .onAppear {
                        if !isPreview {
                            print("requesting solve count")
                            watchManager.requestCurrentSolveCount()
                        }
                    }
                }
            }
        }
    }
}
    
    #Preview {
        ContentView(isPreview: true)
    }
