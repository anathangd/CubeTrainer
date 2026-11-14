import SwiftUI
import AVKit
import UIKit
import UniformTypeIdentifiers

struct SolveVideoView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showingCamera = false
    @State private var videoURL: URL?
    @State private var errorMessage: String?
    @State private var confirmingDiscard = false
    let onUseTimes: ([TimeInterval]) -> Void

    var body: some View {
        NavigationStack {
            ZStack {
                Color.yellow.ignoresSafeArea()

                if let videoURL {
                    SolveVideoReviewView(url: videoURL) { durations in
                        onUseTimes(durations)
                        dismiss()
                    }
                } else if let errorMessage {
                    ContentUnavailableView {
                        Label("Camera Unavailable", systemImage: "video.slash")
                    } description: {
                        Text(errorMessage)
                    } actions: {
                        Button("Open Settings") {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url)
                            }
                        }
                    }
                } else {
                    ProgressView("Opening camera")
                }
            }
            .navigationTitle(videoURL == nil ? "Record Solve" : "Review Solve")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.yellow, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        if videoURL != nil { confirmingDiscard = true } else { dismiss() }
                    }
                }
            }
            .confirmationDialog("Discard this recording and its markers?", isPresented: $confirmingDiscard, titleVisibility: .visible) {
                Button("Discard Recording", role: .destructive) { dismiss() }
                Button("Cancel", role: .cancel) {}
            }
        }
        .interactiveDismissDisabled()
        .task { await openCamera() }
        .fullScreenCover(isPresented: $showingCamera) {
            SolveCameraView { url in
                if let url {
                    do {
                        let destination = FileManager.default.temporaryDirectory
                            .appendingPathComponent("Solve-\(UUID().uuidString)")
                            .appendingPathExtension(url.pathExtension)
                        try FileManager.default.copyItem(at: url, to: destination)
                        videoURL = destination
                    } catch {
                        errorMessage = "The recording could not be opened: \(error.localizedDescription)"
                    }
                } else {
                    dismiss()
                }
                showingCamera = false
            }
            .ignoresSafeArea()
        }
        .onDisappear {
            if let videoURL { try? FileManager.default.removeItem(at: videoURL) }
        }
    }

    @MainActor
    private func openCamera() async {
        guard UIImagePickerController.isSourceTypeAvailable(.camera),
              UIImagePickerController.availableMediaTypes(for: .camera)?.contains(UTType.movie.identifier) == true else {
            errorMessage = "Video recording requires a device with a camera."
            return
        }
        let cameraAllowed = await AVCaptureDevice.requestAccess(for: .video)
        guard cameraAllowed else {
            errorMessage = "Allow camera access in Settings to record a solve."
            return
        }
        let microphoneAllowed = await AVCaptureDevice.requestAccess(for: .audio)
        guard microphoneAllowed else {
            errorMessage = "Allow microphone access in Settings to record video with sound."
            return
        }
        guard !Task.isCancelled else { return }
        showingCamera = true
    }
}

private struct SolveCameraView: UIViewControllerRepresentable {
    let onFinish: (URL?) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.mediaTypes = [UTType.movie.identifier]
        picker.cameraCaptureMode = .video
        picker.videoQuality = .typeHigh
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator(onFinish: onFinish) }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let onFinish: (URL?) -> Void

        init(onFinish: @escaping (URL?) -> Void) { self.onFinish = onFinish }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            onFinish(info[.mediaURL] as? URL)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) { onFinish(nil) }
    }
}

private struct SolveVideoReviewView: View {
    let url: URL
    let onUseTimes: ([TimeInterval]) -> Void
    @State private var player = AVPlayer()
    @State private var timeline = SolveVideoTimeline()
    @State private var duration: TimeInterval = 0
    @State private var position: TimeInterval = 0
    @State private var frameDuration: TimeInterval = 1.0 / 30.0
    @State private var isPlaying = false
    @State private var isSeeking = false
    @State private var latestSeekID = UUID()
    @State private var showingExport = false
    @State private var loadError: String?
    @State private var isRecognizingAudio = false
    @State private var speechRecognitionMessage: String?
    @State private var canRetryOnDevice = false
    @State private var showingAppleRecognitionConsent = false
    @AppStorage("allowAppleSpeechRecognitionForSolveVideos") private var allowsAppleSpeechRecognition = false
    private let playbackUpdates = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                VideoPlayer(player: player)
                    .aspectRatio(4.0 / 3.0, contentMode: .fit)
                    .background(.black)

                if let loadError {
                    Text(loadError).foregroundStyle(.red)
                } else if duration == 0 {
                    ProgressView("Loading recording")
                }

                HStack {
                    Text(position.formatted(.number.precision(.fractionLength(3))))
                    Spacer()
                    Text(duration.formatted(.number.precision(.fractionLength(3))))
                }
                .monospacedDigit()

                Slider(value: Binding(get: { position }, set: { seek(to: $0) }), in: 0...max(duration, 0.001))
                    .disabled(duration == 0)
                    .accessibilityLabel("Video timeline")

                HStack(spacing: 8) {
                    Button {
                        if let timestamp = timeline.previousTimestamp(before: position) {
                            seek(to: timestamp)
                        }
                    } label: {
                        Image(systemName: "backward.end.fill")
                            .frame(width: 24, height: 24)
                    }
                    .accessibilityLabel("Previous timestamp")
                    .help("Previous timestamp")
                    .disabled(isSeeking || timeline.previousTimestamp(before: position) == nil)

                    Button { seek(to: position - frameDuration) } label: {
                        Image(systemName: "backward.frame.fill")
                            .frame(width: 24, height: 24)
                    }
                    .accessibilityLabel("Previous frame")
                    .help("Previous frame")
                    Button {
                        if player.timeControlStatus == .playing {
                            player.pause()
                            isPlaying = false
                        } else {
                            if position >= duration {
                                player.seek(to: .zero)
                            }
                            player.play()
                            isPlaying = true
                        }
                    } label: {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .frame(width: 24, height: 24)
                    }
                    .accessibilityLabel(isPlaying ? "Pause" : "Play")
                    .disabled(isSeeking)
                    Button { seek(to: position + frameDuration) } label: {
                        Image(systemName: "forward.frame.fill")
                            .frame(width: 24, height: 24)
                    }
                    .accessibilityLabel("Next frame.fill")
                    .help("Next frame")

                    Button {
                        if let timestamp = timeline.nextTimestamp(after: position) {
                            seek(to: timestamp)
                        }
                    } label: {
                        Image(systemName: "forward.end")
                            .frame(width: 24, height: 24)
                    }
                    .accessibilityLabel("Next timestamp")
                    .help("Next timestamp")
                    .disabled(isSeeking || timeline.nextTimestamp(after: position) == nil)
                }
                .font(.title2)
                .buttonStyle(.bordered)
                .disabled(duration == 0)

                Button {
                    if allowsAppleSpeechRecognition {
                        Task { await autoMarkFromAudio(requiresOnDeviceRecognition: false) }
                    } else {
                        showingAppleRecognitionConsent = true
                    }
                } label: {
                    if isRecognizingAudio {
                        ProgressView("Finding spoken markers")
                            .frame(maxWidth: .infinity)
                    } else {
                        Label("Auto-Mark From Audio", systemImage: "waveform")
                            .frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.bordered)
                .disabled(duration == 0 || isRecognizingAudio)
                .confirmationDialog(
                    "Use Apple Speech Recognition?",
                    isPresented: $showingAppleRecognitionConsent,
                    titleVisibility: .visible
                ) {
                    Button("Continue") {
                        allowsAppleSpeechRecognition = true
                        Task { await autoMarkFromAudio(requiresOnDeviceRecognition: false) }
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Solve audio may be sent to Apple for speech recognition. Your choice is remembered on this device.")
                }

                if let speechRecognitionMessage {
                    Text(speechRecognitionMessage)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                if canRetryOnDevice {
                    Button("Retry On-Device Instead") {
                        Task { await autoMarkFromAudio(requiresOnDeviceRecognition: true) }
                    }
                    .buttonStyle(.bordered)
                }

                if let nextLabel = timeline.nextLabel {
                    Button {
                        let time = player.currentTime().seconds
                        if timeline.mark(at: time, duration: duration) {
                            position = time
                            if timeline.phaseDurations != nil {
                                player.pause()
                                isPlaying = false
                            }
                        }
                    } label: {
                        Label(nextLabel, systemImage: "flag.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(isSeeking || !timeline.canMark(at: position, duration: duration))
                }
                
                HStack {
                    Button {
                        player.pause()
                        isPlaying = false
                        timeline.undo()
                    } label: {
                        Label("Undo Marker", systemImage: "arrow.uturn.backward")
                    }
                    .disabled(timeline.timestamps.isEmpty)
                    Spacer()
                    Button {
                        player.pause()
                        isPlaying = false
                        showingExport = true
                    } label: {
                        Label("Export Video", systemImage: "square.and.arrow.up")
                    }
                }

                Divider()
                Text("Timestamps")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityAddTraits(.isHeader)

                ForEach(Array(SolveVideoTimeline.labels.enumerated()), id: \.offset) { index, label in
                    HStack {
                        Text(label)
                        Spacer()
                        if index < timeline.timestamps.count {
                            Button {
                                seek(to: timeline.timestamps[index])
                            } label: {
                                Text(timeline.timestamps[index].formatted(.number.precision(.fractionLength(3))))
                                    .monospacedDigit()
                            }
                            .accessibilityLabel("Seek to \(label)")
                        } else {
                            Text("Not marked").foregroundStyle(.secondary)
                        }
                    }
                }

                if let durations = timeline.phaseDurations {
                    Divider()
                    Text("Times")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityAddTraits(.isHeader)

                    ForEach(Array(durations.enumerated()), id: \.offset) { index, time in
                        HStack {
                            Text(["Cross", "F2L", "OLL", "PLL"][index])
                            Spacer()
                            Text("\(time, specifier: "%.2f") s").monospacedDigit()
                        }
                    }
                    HStack {
                        Text("Total").bold()
                        Spacer()
                        Text("\(durations.reduce(0, +), specifier: "%.2f") s").bold().monospacedDigit()
                    }
                    Button {
                        player.pause()
                        onUseTimes(durations)
                    } label: {
                        Label("Use Times", systemImage: "checkmark")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
        .task {
            do {
                let asset = AVURLAsset(url: url)
                let loadedDuration = try await asset.load(.duration).seconds
                guard loadedDuration.isFinite, loadedDuration > 0 else {
                    loadError = "This recording has no playable duration."
                    return
                }
                if let track = try await asset.loadTracks(withMediaType: .video).first {
                    let interval = try await track.load(.minFrameDuration).seconds
                    if interval.isFinite, interval > 0 { frameDuration = interval }
                }
                guard !Task.isCancelled else { return }
                player.replaceCurrentItem(with: AVPlayerItem(asset: asset))
                duration = loadedDuration
            } catch {
                loadError = "Could not load the recording: \(error.localizedDescription)"
            }
        }
        .onReceive(playbackUpdates) { _ in
            if !isSeeking {
                let time = player.currentTime().seconds
                if time.isFinite { position = min(max(time, 0), duration) }
            }
            isPlaying = player.timeControlStatus == .playing
        }
        .sheet(isPresented: $showingExport) { SolveVideoExportView(url: url) }
        .onDisappear { player.pause() }
    }

    private func seek(to time: TimeInterval) {
        player.pause()
        isPlaying = false
        let target = min(max(time, 0), duration)
        position = target
        isSeeking = true
        let seekID = UUID()
        latestSeekID = seekID
        player.seek(to: CMTime(seconds: target, preferredTimescale: 60000), toleranceBefore: .zero, toleranceAfter: .zero) { _ in
            DispatchQueue.main.async {
                if latestSeekID == seekID { isSeeking = false }
            }
        }
    }

    @MainActor
    private func autoMarkFromAudio(requiresOnDeviceRecognition: Bool) async {
        player.pause()
        isPlaying = false
        isRecognizingAudio = true
        speechRecognitionMessage = nil
        canRetryOnDevice = false
        defer { isRecognizingAudio = false }

        let authorization = await SolveVideoSpeechMarkerRecognizer.requestAuthorization()
        guard authorization == .authorized else {
            speechRecognitionMessage = SolveVideoSpeechMarkerRecognizer.RecognitionError.notAuthorized.localizedDescription
            return
        }

        do {
            let result = try await SolveVideoSpeechMarkerRecognizer.recognizeMarkers(
                in: url,
                requiresOnDeviceRecognition: requiresOnDeviceRecognition
            )
            guard !result.transcript.isEmpty else {
                speechRecognitionMessage = "No speech was recognized. Check that the recording has audible microphone audio, then try again."
                canRetryOnDevice = !result.usedOnDeviceRecognition
                return
            }
            guard result.timestamps.count == SolveVideoTimeline.labels.count else {
                speechRecognitionMessage = "Heard: \(result.transcript). Found \(result.timestamps.count) of 5 cues; say “start” once, then “done” after each phase. Add the missing timestamps manually."
                canRetryOnDevice = !result.usedOnDeviceRecognition
                return
            }
            guard timeline.setTimestamps(result.timestamps, duration: duration) else {
                speechRecognitionMessage = "Heard: \(result.transcript). The cues were outside the recording or out of order. Add the timestamps manually."
                return
            }
            seek(to: result.timestamps[0])
            speechRecognitionMessage = "Heard: \(result.transcript). Found all five cues. Review the timestamps, then adjust them manually if needed."
        } catch {
            speechRecognitionMessage = error.localizedDescription
        }
    }
}

private struct SolveVideoExportView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: [url], applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
