//
//  RoofpigTestView.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 10/19/25.
//

import SwiftUI
import WebKit

struct RoofpigTestView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.yellow)
            VStack {
                Text("Algorithms left: 1")
                
                Text("corner edge top 1")
                    .padding(.top, 10)
                RoofPigView(algorithm: "R U R' U' R U R'", mirrored: false)
                    .frame(width: 400, height: 450)
                Text("R U R' U' R U R'")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .padding()
                Spacer()
            }
            VStack {
                Spacer()
                Image(systemName: "arrow.left.and.right.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(Color.indigo)
                HStack {
                    Button { //right
                        
                    } label: {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 50))
                            .foregroundStyle(Color.green)
                            .background(.blue, in: Circle())
                            .padding(20)
                    }
                    Button { //wrong
                        
                    } label: {
                        Image(systemName: "x.circle")
                            .font(.system(size: 50))
                            .foregroundStyle(Color.orange)
                            .background(.red, in: Circle())
                            .padding(20)
                    }
                } // correct and incorrect buttons
            }
        }
    }
}

//#Preview {
//    RoofpigTestView()
//}

struct RoofPigView: UIViewRepresentable {
    let algorithm: String
    let mirrored: Bool

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        // Disable scrolling and zooming
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.pinchGestureRecognizer?.isEnabled = false
        
        print("🔍 Attempting to load f2l.html")
        if let htmlPath = Bundle.main.path(forResource: "f2l", ofType: "html") {
            print("✅ Found f2l.html at \(htmlPath)")
            if var html = try? String(contentsOfFile: htmlPath, encoding: .utf8) {
                // Inject the algorithm dynamically
                let algString = mirrored ? "\(algorithm)'" : algorithm
                html = html.replacingOccurrences(of: "{{ALG}}", with: algString)
                print("📝 Loaded HTML (first 200 chars): \(html.prefix(200))")
                print("📦 Loading HTML into WKWebView...")
                webView.loadHTMLString(html, baseURL: Bundle.main.bundleURL)
                print("✅ Load request sent to WKWebView")
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
    
    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("🌐 WebView finished loading successfully")
        }
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("⚠️ WebView failed with error: \(error.localizedDescription)")
        }
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("⚠️ WebView failed with error: \(error.localizedDescription)")
        }
    }
}
