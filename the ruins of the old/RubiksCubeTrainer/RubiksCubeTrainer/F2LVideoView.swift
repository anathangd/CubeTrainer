//
//  F2LVideoView.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 2025-06-13.
//

//import SwiftUI
//import AVKit
//
//struct F2LVideoView: View {
//    let videoName: String
//
//    var body: some View {
//        if let url = Bundle.main.url(forResource: videoName, withExtension: "mov") {
//            VideoPlayer(player: AVPlayer(url: url))
//                .frame(width: 314, height: 360)
//                .cornerRadius(12)
//                .shadow(radius: 4)
//        } else {
//            Text("Video not found")
//                .foregroundColor(.red)
//        }
//    }
//}

import SwiftUI
import AVFoundation

struct F2LVideoView: UIViewRepresentable {
    let videoName: String
    let videoType: String
    @Binding var playTrigger: Bool

    class Coordinator {
        var player: AVPlayer?
        var playerLayer: AVPlayerLayer?
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView()

        guard let path = Bundle.main.path(forResource: videoName, ofType: videoType) else {
            return view
        }

        let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspect
        playerLayer.frame = view.bounds

        view.layer.addSublayer(playerLayer)

        context.coordinator.player = player
        context.coordinator.playerLayer = playerLayer

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.playerLayer?.frame = uiView.bounds

        if playTrigger {
            context.coordinator.player?.seek(to: .zero)
            context.coordinator.player?.play()

            DispatchQueue.main.async {
                self.playTrigger = false
            }
        }
    }
}

//#Preview {
//    F2LVideoView(videoName: "corner up edge top 1")
//}
