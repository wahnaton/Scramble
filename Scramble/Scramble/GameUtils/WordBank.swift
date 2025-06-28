import Foundation

enum WordBank {
    static let letters: [String] = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map(String.init)
    static let words: [String] = {
        guard let url = Bundle.main.url(forResource: "five_letter_words",
                                        withExtension: "txt"),
              let text = try? String(contentsOf: url, encoding: .utf8) else {
            fatalError("Word list missing from bundle")
        }
        return text.split(whereSeparator: \.isNewline).map(String.init)
    }()

    static func random() -> String {
        words.randomElement()!.uppercased()
    }
}
