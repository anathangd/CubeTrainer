//
//  PLLRecView.swift
//  RubiksCubeTrainerWatch Watch App
//
//  Created by Nathan Davis on 3/9/26.
//

import SwiftUI

struct PLLRecView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var active: [Algorithm]
    @State private var count: Int = 0
    @State private var showAll: Bool = false
    @State private var imageVariant: Int = Int.random(in: 1...4)
    private let eightVariantImages: Set<String> = [
        "3colorcheckermiddle",
        "noblocksnochecker",
        "oneblockinside",
        "oneblockoutside"
    ]
    @State private var committedOffset: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    private var currentImageName: String {
        guard let baseName = active.first?.name, !baseName.isEmpty else {
            return "Loading..."
        }

        var name = baseName
        name.removeLast()
        let fullName = name + String(imageVariant)
        print("Current image variant selected:", fullName)
        return fullName
    }
    
    init() {
        let cases = PLLRecognitionAbridgedCases.cases.shuffled()
        _active = State(initialValue: cases)
    }
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.yellow)
                .onTapGesture {
                    WKInterfaceDevice.current().play(.click)
                    showAll.toggle()
                }
            if !active.isEmpty {
                Image(currentImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 180)
                    .allowsHitTesting(false)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Text(String(active.count))
                            .shadow(color: .black, radius: 2)
                            .shadow(color: .black, radius: 6)
                            .padding()
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
                                .frame(maxWidth: .infinity, minHeight: 80, maxHeight: 80)
                                .overlay(alignment: .bottomLeading) {
                                    Image(systemName: "checkmark.circle")
                                        .font(.system(size: 40))
                                        .foregroundStyle(Color.green)
                                        .shadow(color: .black.opacity(0.7), radius: 2)
                                        .background(.blue, in: Circle())
                                        .padding()
                                }
                        }
                        .buttonStyle(.plain)
                        Button { //wrong
                            markIncorrect()
                        } label: {
                            RightCornerTriangle()
                                .fill(.red)
                                .frame(maxWidth: .infinity, minHeight: 80, maxHeight: 80)
                                .overlay(alignment: .bottomTrailing) {
                                    Image(systemName: "x.circle")
                                        .font(.system(size: 40))
                                        .foregroundStyle(Color.orange)
                                        .shadow(color: .black.opacity(0.7), radius: 2)
                                        .background(.red, in: Circle())
                                        .padding()
                                }
                        }
                        .buttonStyle(.plain)
                    } // correct and incorrect buttons
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .fill(.black.opacity(0.65))
                            .frame(width: 1, height: 16)
                            .blur(radius: 0.5)
                    }
                }
                .ignoresSafeArea()
                Text(active.first?.algorithm ?? "Loading...")
                    .font(.system(size: 24))
                    .shadow(color: .black, radius: 2)
                    .shadow(color: .black, radius: 6)
                    .lineLimit(4)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .opacity(showAll ? 1 : 0)
                    .padding(.top, -10)
                    .allowsHitTesting(false)
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
        .onAppear {
            refreshImageVariantForCurrentCard()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func refreshImageVariantForCurrentCard() {
        guard let originalName = active.first?.name,
              let lastChar = originalName.last,
              let lastDigit = Int(String(lastChar)) else {
            imageVariant = 1
            return
        }

        var baseName = originalName
        baseName.removeLast()

        if eightVariantImages.contains(baseName) {
            if (1...4).contains(lastDigit) {
                imageVariant = Int.random(in: 1...4)
            } else if (5...8).contains(lastDigit) {
                imageVariant = Int.random(in: 5...8)
            } else {
                imageVariant = lastDigit
            }
        } else {
            imageVariant = Int.random(in: 1...4)
        }

        print("PLLRec current card:", originalName, "-> imageVariant:", imageVariant, "-> current image:", currentImageName)
    }
    
    private func next() {
        count += 1
        showAll = false
        refreshImageVariantForCurrentCard()
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

struct LeftCornerTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        // path.addLine(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.81))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct RightCornerTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY * 0.81))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}


#Preview {
    PLLRecView()
}
