import AVFoundation
import Speech

struct SolveVideoSpeechMarkerRecognizer {
    struct RecognitionResult {
        let transcript: String
        let timestamps: [TimeInterval]
        let usedOnDeviceRecognition: Bool
    }

    struct Word {
        let text: String
        let time: TimeInterval
    }

    enum RecognitionError: LocalizedError {
        case notAuthorized
        case recognizerUnavailable
        case noAudioTrack
        case audioExportFailed(String)

        var errorDescription: String? {
            switch self {
            case .notAuthorized:
                return "Allow Speech Recognition in Settings to find spoken markers."
            case .recognizerUnavailable:
                return "Speech recognition is currently unavailable. Check your connection and try again."
            case .noAudioTrack:
                return "No audio track was recorded. Check microphone access and record the solve again."
            case .audioExportFailed(let detail):
                return "Could not read the recording's audio: \(detail)"
            }
        }
    }

    static func requestAuthorization() async -> SFSpeechRecognizerAuthorizationStatus {
        await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status)
            }
        }
    }

    static func recognizeMarkers(
        in videoURL: URL,
        requiresOnDeviceRecognition: Bool? = nil
    ) async throws -> RecognitionResult {
        guard SFSpeechRecognizer.authorizationStatus() == .authorized else {
            throw RecognitionError.notAuthorized
        }
        guard let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US")), recognizer.isAvailable else {
            throw RecognitionError.recognizerUnavailable
        }
        let useOnDeviceRecognition = requiresOnDeviceRecognition ?? recognizer.supportsOnDeviceRecognition

        let audioURL = FileManager.default.temporaryDirectory
            .appendingPathComponent("SolveAudio-\(UUID().uuidString)")
            .appendingPathExtension("m4a")
        defer { try? FileManager.default.removeItem(at: audioURL) }
        try await exportAudio(from: videoURL, to: audioURL)

        let request = SFSpeechURLRecognitionRequest(url: audioURL)
        request.shouldReportPartialResults = false
        request.taskHint = .dictation
        request.contextualStrings = [
            "start", "start solve", "done", "cross done", "F2L done", "OLL done", "PLL done"
        ]
        request.requiresOnDeviceRecognition = useOnDeviceRecognition

        let recognition: (String, [Word]) = try await withCheckedThrowingContinuation {
            (continuation: CheckedContinuation<(String, [Word]), Error>) in
            recognizer.recognitionTask(with: request) { result, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let result, result.isFinal else { return }
                let transcription = result.bestTranscription
                let words = transcription.segments.map {
                    Word(text: $0.substring, time: $0.timestamp)
                }
                continuation.resume(returning: (transcription.formattedString, words))
            }
        }

        return RecognitionResult(
            transcript: recognition.0,
            timestamps: proposedTimestamps(from: recognition.1),
            usedOnDeviceRecognition: useOnDeviceRecognition
        )
    }

    static func proposedTimestamps(from words: [Word]) -> [TimeInterval] {
        var timestamps: [TimeInterval] = []
        var hasStarted = false

        for word in words {
            let normalized = word.text.lowercased().filter(\.isLetter)
            guard word.time.isFinite else { continue }
            if normalized == "start", !hasStarted {
                timestamps.append(word.time)
                hasStarted = true
            } else if normalized == "done", hasStarted, timestamps.count < 5 {
                timestamps.append(word.time)
            }
        }
        return timestamps
    }

    private static func exportAudio(from videoURL: URL, to audioURL: URL) async throws {
        let asset = AVURLAsset(url: videoURL)
        let audioTracks = try await asset.loadTracks(withMediaType: .audio)
        guard !audioTracks.isEmpty else {
            throw RecognitionError.noAudioTrack
        }
        guard let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A) else {
            throw RecognitionError.audioExportFailed("This video format cannot be converted.")
        }
        exporter.outputURL = audioURL
        exporter.outputFileType = .m4a
        do {
            try await exporter.export(to: audioURL, as: .m4a)
        } catch {
            throw RecognitionError.audioExportFailed(error.localizedDescription)
        }
    }
}