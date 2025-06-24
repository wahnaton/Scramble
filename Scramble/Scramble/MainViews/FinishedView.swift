//
//  FinishedView.swift
//  Scramble
//
//  Created by ChatGPT on 2025‑06‑23.
//

import SwiftUI
import UniformTypeIdentifiers

/// Shown when the run is complete.
struct FinishedView: View {
    @EnvironmentObject private var game: GameState
    @State private var isCopied = false
    
    private var formattedTime: String {
        String(format: "%.1f s", game.elapsedTime)
    }
    
    /// Text shared / copied by the user.
    private var shareText: String {
        "I finished Scramble in \(formattedTime)! Can you beat me? #ScrambleApp"
    }
    
    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            
            VStack(spacing: 40) {
                // Title
                Text("Scramble")
                    .font(.system(size: 48, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                
                // Time display
                Text(formattedTime)
                    .font(.system(size: 88, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .yellow.opacity(0.9), radius: 6, x: 0, y: 3)
                
                // Share + copy controls
                HStack(spacing: 24) {
                    ShareLink(item: shareText) {
                        Label("Share", systemImage: "square.and.arrow.up")
                            .font(.title2.bold())
                            .padding(.horizontal, 28)
                            .padding(.vertical, 14)
                            .foregroundStyle(.white)
                            .background(
                                Capsule().fill(Color.pink)
                            )
                            .shadow(radius: 3, y: 2)
                    }
                    
                    Button {
                        UIPasteboard.general.setValue(shareText, forPasteboardType: UTType.plainText.identifier)
                        withAnimation { isCopied = true }
                        // Hide confirmation after 2 s
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation { isCopied = false }
                        }
                    } label: {
                        Label(isCopied ? "Copied!" : "Copy", systemImage: "doc.on.doc")
                            .font(.title3.bold())
                            .padding(.horizontal, 24)
                            .padding(.vertical, 14)
                            .foregroundStyle(.white)
                            .background(
                                Capsule().fill(Color.orange)
                            )
                            .shadow(radius: 3, y: 2)
                    }
                }
                
                // Play again button
                Button {
                    game.startRun()      // reset timer for new run
                    game.level = .one
                } label: {
                    Text("Play Again")
                        .font(.title.bold())
                        .padding(.horizontal, 64)
                        .padding(.vertical, 22)
                        .foregroundStyle(.white)
                        .background(
                            Capsule().fill(Color.green)
                        )
                        .shadow(radius: 4, y: 3)
                }
                .padding(.top, 20)
            }
        }
    }
}

#Preview {
    let gs = GameState()
    gs.elapsedTime = 42.7
    return FinishedView()
        .environmentObject(gs)
}
