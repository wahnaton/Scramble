import SwiftUI

struct DailyResultView: View {
    let dateKey: String
    let time: TimeInterval?
    @Environment(\.dismiss) private var dismiss

    private var formattedTime: String {
        guard let t = time else { return "—" }
        return String(format: "%.2f s", t)
    }

    private var shareText: String {
        "Scramble Daily (\(dateKey)): I finished in \(formattedTime)! #PlayScrambleGame 🐣"
    }

    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                Text("Daily Result")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.25), radius: 4, y: 3)
                Text(dateKey)
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.9))

                Text(formattedTime)
                    .font(.system(size: 48, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .yellow.opacity(0.8), radius: 6, y: 2)

                ShareLink(item: shareText) {
                    Label("Share", systemImage: "square.and.arrow.up")
                        .font(.title3.bold())
                        .frame(width: 220, height: 50)
                        .foregroundStyle(.white)
                        .background(
                            Capsule().fill(Color.orange)
                        )
                        .shadow(radius: 4, y: 3)
                }

                Button("Done") { dismiss() }
                    .font(.title3.bold())
                    .frame(width: 220, height: 50)
                    .foregroundStyle(.white)
                    .background(
                        Capsule().fill(Color.green)
                    )
                    .shadow(radius: 4, y: 3)

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    DailyResultView(dateKey: DailyRunProvider.shared.todayKey(), time: 12.34)
}
