//
//  RoofPigView.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 10/20/25.
//

import SwiftUI
import WebKit

struct RoofPigView: UIViewRepresentable {
    let algorithm: String
    let setup: String
    let type: String
    let mirrored: Bool
    let rotated: Bool

    func makeUIView(context: Context) -> WKWebView {
        var colored: String
        if type == "AdvF2L" && mirrored && rotated {
            colored = "U D F FD R RD B L LD BD BR BDR"
        } else if type == "AdvF2L" && rotated {
            colored = "U D F FD R RD B L LD BD BL BDL"
        } else if type == "AdvF2L" && mirrored {
            colored = "U D DFL FL F FD R RD B L LD BD"
        } else if type == "AdvF2L" {
            colored = "U D DFR F FD FR R RD B L LD BD"
        } else {
            colored = "U-"
        }
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.scrollView.delegate = context.coordinator
        
        // Disable scrolling and zooming
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.pinchGestureRecognizer?.isEnabled = false
        webView.scrollView.maximumZoomScale = 1.0
        webView.scrollView.minimumZoomScale = 1.0
        
//        print("🔍 Attempting to load f2l.html")
        if let htmlPath = Bundle.main.path(forResource: "f2l", ofType: "html") {
//            print("✅ Found f2l.html at \(htmlPath)")
            if var html = try? String(contentsOfFile: htmlPath, encoding: .utf8) {
                // Inject the algorithm dynamically
                html = html.replacingOccurrences(of: "{{ALG}}", with: algorithm)
                html = html.replacingOccurrences(of: "{{COLORED}}", with: colored)
                html = html.replacingOccurrences(of: "{{SETUP}}", with: setup)
//                print("📝 Loaded HTML (first 200 chars): \(html.prefix(200))")
                print("📦 Loading HTML into WKWebView...")
                webView.loadHTMLString(html, baseURL: Bundle.main.bundleURL)
//                print("✅ Load request sent to WKWebView")
            } else {
                print("❌ Could not read contents of f2l.html")
            }
        } else {
            print("❌ Could not find f2l.html in bundle")
        }
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, UIScrollViewDelegate {
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            let disablePinchJS = """
            (function() {
                var existing = document.querySelector('meta[name="viewport"]');
                if (!existing) {
                    existing = document.createElement('meta');
                    existing.name = 'viewport';
                    document.head.appendChild(existing);
                }
                existing.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';

                ['gesturestart', 'gesturechange', 'gestureend'].forEach(function(type) {
                    document.addEventListener(type, function(e) { e.preventDefault(); }, { passive: false });
                });

                document.addEventListener('touchmove', function(e) {
                    if (e.touches && e.touches.length > 1) {
                        e.preventDefault();
                    }
                }, { passive: false });
            })();
            """

            webView.evaluateJavaScript(disablePinchJS) { _, error in
                if let error {
                    print("⚠️ Failed to disable pinch zoom JS: \(error.localizedDescription)")
                }
            }

            print("🌐 WebView finished loading successfully")
        }

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            nil
        }

        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            if scrollView.zoomScale != 1.0 {
                scrollView.setZoomScale(1.0, animated: false)
            }
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("⚠️ WebView failed with error: \(error.localizedDescription)")
        }
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("⚠️ WebView failed with error: \(error.localizedDescription)")
        }
    }
}

// MARK: - Algorithm Mirroring Helpers
func algorithmStripper(alg: String) -> String {
    var strippedAlgorithm = alg
    strippedAlgorithm = strippedAlgorithm.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
    return strippedAlgorithm
}

func algMirrorerWithParens(alg: String) -> String {
    let moves = alg.split(separator: " ")
    var mirrored = ""

    for moveSub in moves {
        var move = String(moveSub)
        var prefix = ""
        var suffix = ""

        // Extract parentheses
        if move.contains("(") {
            prefix = "("
            move = move.replacingOccurrences(of: "(", with: "")
        }
        if move.contains(")") {
            suffix = ")"
            move = move.replacingOccurrences(of: ")", with: "")
        }

        // Mirror core move
        var mirroredMove: String
        switch move {
        case "R":   mirroredMove = "L'"
        case "R'":  mirroredMove = "L"
        case "L":   mirroredMove = "R'"
        case "L'":  mirroredMove = "R"
        case "F":   mirroredMove = "F'"
        case "F'":  mirroredMove = "F"
        case "B":   mirroredMove = "B'"
        case "B'":  mirroredMove = "B"
        case "U":   mirroredMove = "U'"
        case "U'":  mirroredMove = "U"
        case "D":   mirroredMove = "D'"
        case "D'":  mirroredMove = "D"
        case "y":   mirroredMove = "y'"
        case "y'":  mirroredMove = "y"
        case "d":   mirroredMove = "d'"
        case "d'":  mirroredMove = "d"
        case "f":   mirroredMove = "f'"
        case "f'":  mirroredMove = "f"
        case "b":   mirroredMove = "b'"
        case "b'":  mirroredMove = "b"
        case "u":   mirroredMove = "u'"
        case "u'":  mirroredMove = "u"
        case "R2":  mirroredMove = "L2'"
        case "R2'": mirroredMove = "L2"
        case "L2":  mirroredMove = "R2'"
        case "L2'": mirroredMove = "R2"
        case "F2":  mirroredMove = "F2"
        case "B2":  mirroredMove = "B2"
        case "U2'":  mirroredMove = "U2"
        case "U2":  mirroredMove = "U2'"
        case "D2":  mirroredMove = "D2"
        case "S":   mirroredMove = "S'"
        case "S'": mirroredMove = "S"
        default:
            mirroredMove = move
            print("Move not found: \(move)")
        }

        mirrored += "\(prefix)\(mirroredMove)\(suffix) "
    }

    print(alg.replacingOccurrences(of: " ", with: "\t"))
    print(mirrored.replacingOccurrences(of: " ", with: "\t"))

    print("\n\(mirrored)")

    return mirrored.trimmingCharacters(in: .whitespaces)
}

func algRotator(alg: String) -> String {
    let moves = alg.split(separator: " ")
    var rotated: String = ""
    
    for moveSub in moves {
        var move = String(moveSub)
        var prefix = ""
        var suffix = ""
        
        if move.contains("(") {
            prefix = "("
            move = move.replacingOccurrences(of: "(", with: "")
        }
        if move.contains(")") {
            suffix = ")"
            move = move.replacingOccurrences(of: ")", with: "")
        }
        var rotatedMove: String
        switch move {
        case "R": rotatedMove = "L"
        case "L": rotatedMove = "R"
        case "R'": rotatedMove = "L'"
        case "L'": rotatedMove = "R'"
        case "R2": rotatedMove = "L2"
        case "R2'": rotatedMove = "L2'"
        case "L2": rotatedMove = "R2"
        case "L2'": rotatedMove = "R2'"
        case "F": rotatedMove = "B"
        case "F'": rotatedMove = "B'"
        case "B": rotatedMove = "F"
        case "B'": rotatedMove = "F'"
        case "f": rotatedMove = "b"
        case "f'": rotatedMove = "b'"
        case "b": rotatedMove = "f"
        case "b'": rotatedMove = "f'"
        case "S": rotatedMove = "S'"
        case "S'": rotatedMove = "S"
        case "U2": rotatedMove = "U2'"
        case "U2'": rotatedMove = "U2"
        
        default: rotatedMove = move
        }
        rotated += "\(prefix)\(rotatedMove)\(suffix) "
    }
    return rotated.trimmingCharacters(in: .whitespaces)
}

func setupMirrorer(setup: String) -> String {
    var mirrored: String
    switch setup {
    case "y2": mirrored = "y2"
    case "y": mirrored = "y'"
    case "y'": mirrored = "y"
    case "" : mirrored = setup
    default:
        mirrored = setup
        print("case not found for setup: \(setup)")
    }
    return mirrored
}
