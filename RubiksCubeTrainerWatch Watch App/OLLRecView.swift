//
//  OLLRecView.swift
//  RubiksCubeTrainerWatch Watch App
//
//  Created by Nathan Davis on 5/8/26.
//

import SwiftUI

struct OLLRecView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var active: [Algorithm]
    @State private var count: Int = 0
    @State private var showAll: Bool = false
    @State private var committedOffset: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    init() {
        let cases = OLLRecAbridgedCases.cases.shuffled()
        _active = State(initialValue: cases)
    }
    var body: some View {
        GeometryReader { geo in
            let screenHeight = WKInterfaceDevice.current().screenBounds.height
            let imageHeight = screenHeight * 0.6
            let answerImageHeight = screenHeight * 0.6
            let wedgeHeight = screenHeight * 0.4
            let imageScale = 1.25
            let answerImageScale = 1.05

            ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.yellow)
                .onTapGesture {
                    WKInterfaceDevice.current().play(.click)
                    showAll.toggle()
                }
            if !active.isEmpty {
                VStack {
                    if !showAll {
                        Image(active.first?.name ?? "Loading...")
                            .resizable()
                            .scaledToFit()
                            .frame(height: imageHeight)
                            .scaleEffect(imageScale, anchor: .top)
                            .allowsHitTesting(false)
                            .padding(.top)
                            .ignoresSafeArea()
                    } else {
                        Image(active.first?.answer ?? "Loading...")
                            .resizable()
                            .scaledToFit()
                            .frame(height: answerImageHeight)
                            .scaleEffect(answerImageScale, anchor: .top)
                            .allowsHitTesting(false)
                            .padding()
                            .padding(.top, 5)
                            .ignoresSafeArea()
                    }
                    Spacer()
                }
                VStack {
                    HStack {
                        Text(String(active.count))
                            .shadow(color: .black, radius: 2)
                            .shadow(color: .black, radius: 6)
                            .padding()
                            .padding(.leading, screenHeight > 224 ? 10 : 0)
                        Spacer()
                    }
                    Spacer()
                }
                .ignoresSafeArea()
                VStack {
                    Spacer()
                    HStack(spacing: 0) {
                        Button { //right
                            markCorrect()
                        } label: {
                            LeftCornerTriangle()
                                .fill(.blue)
                                .frame(maxWidth: .infinity, minHeight: wedgeHeight, maxHeight: wedgeHeight)
                                .overlay(alignment: .bottomLeading) {
                                    Image(systemName: "checkmark.circle")
                                        .font(.system(size: 40))
                                        .foregroundStyle(Color.green)
                                        .shadow(color: .black.opacity(0.7), radius: 2)
                                        .background(.blue, in: Circle())
                                        .padding(.bottom, screenHeight > 224 ? 12 : 8)
                                        .padding(.leading, screenHeight > 224 ? 12 : 8)
                                }
                        }
                        .buttonStyle(.plain)
                        Button { //wrong
                            markIncorrect()
                        } label: {
                            RightCornerTriangle()
                                .fill(.red)
                                .frame(maxWidth: .infinity, minHeight: wedgeHeight, maxHeight: wedgeHeight)
                                .overlay(alignment: .bottomTrailing) {
                                    Image(systemName: "x.circle")
                                        .font(.system(size: 40))
                                        .foregroundStyle(Color.orange)
                                        .shadow(color: .black.opacity(0.7), radius: 2)
                                        .background(.red, in: Circle())
                                        .padding(.bottom, screenHeight > 224 ? 12 : 8)
                                        .padding(.trailing, screenHeight > 224 ? 12 : 8)
                                }
                        }
                        .buttonStyle(.plain)
                    } // correct and incorrect buttons
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .fill(.black.opacity(0.65))
                            .frame(width: 1, height: 24)
                            .blur(radius: 0.5)
                    }
                }
                .ignoresSafeArea()
                VStack {
                    Spacer()
                    Text(active.first?.algorithm ?? "Loading...")
                        .font(.system(size: 24))
                        .shadow(color: .black, radius: 2)
                        .shadow(color: .black, radius: 6)
                        .lineLimit(2)
                        .minimumScaleFactor(0.4)
                        .multilineTextAlignment(.center)
                        .opacity(showAll ? 1 : 0)
                        .padding(.bottom, 10)
                        .allowsHitTesting(false)
                        .frame(maxWidth: geo.size.width * 0.8, maxHeight: screenHeight * 0.3, alignment: .top)
                }
                .ignoresSafeArea()
            }
            if active.isEmpty {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundStyle(.yellow)
                VStack {
                    Text("You did it! 🎉")
                    Text("You cycled through the stack \(count) times!")
                        .multilineTextAlignment(.center)
                    Button("back") {
                        dismiss()
                    }
                    .padding(.horizontal)
                    .padding()
                }
                .foregroundStyle(.black)
            } // clear screen
        }
            .onAppear {
                print("Geometry height:", geo.size.height)
                print("Screen bounds:", WKInterfaceDevice.current().screenBounds)
            }
        .offset(x: committedOffset + dragOffset)
        .animation(.interactiveSpring(), value: dragOffset)
        .gesture(
            DragGesture(minimumDistance: 10)
                .updating($dragOffset) { value, state, _ in
                    if value.translation.width > 0 {
                        state = value.translation.width
                    }
                }
                .onEnded { value in
                    if value.translation.width > 80 && abs(value.translation.height) < 40 {
                        committedOffset = 220
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                            dismiss()
                        }
                    }
                }
        )
        .navigationBarBackButtonHidden(true)
    }
    }
    
    private func next() {
        count += 1
        showAll = false
    }
    
    private func markCorrect() {
        if !active.isEmpty {
            active.removeFirst()
        }
        WKInterfaceDevice.current().play(.success)
        next()
    }
    
    private func markIncorrect() {
        active.append(active.removeFirst())
        WKInterfaceDevice.current().play(.failure)
        next()
    }
    
}

#Preview {
    OLLRecView()
}
