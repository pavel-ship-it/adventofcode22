import Foundation
class Task9: Task {
    func move(_ num: Int, _ from: Int, _ to: Int) {
        for _ in (0..<num) {
            cargo[to-1].append(cargo[from-1].popLast()!)
        }
    }

    var cargo = [[String]](repeating: [String](), count: 9)
    func expected() -> String { "MQTPGLLDN" }

    func calc(_ inputFile: String) -> Int {
        let input = fileData(inputFile)
        input.prefix(8).reversed()
            .forEach {
                let line = Array($0)
                var pile = 0
                for i in stride(from: 1, to: 34, by: 4) {
                    if String(line[i]) == " " {
                        pile += 1
                        continue
                    }
                    cargo[pile].append(String(line[i]))
                    pile += 1
                }
            }

        input.suffix(from: 9)
            .map { $0
                .components(separatedBy: CharacterSet(charactersIn: " "))
                .compactMap { Int($0) }
            }
            .forEach {
                move($0[0], $0[1], $0[2])
            }

        let outcome = cargo.compactMap { $0.last }.joined()
        if outcome == expected() {
            print ("\(String(describing: Self.self)) - '\(outcome)' is ok")
        } else {
            print ("\(String(describing: Self.self)) - '\(outcome)' should be 'MQTPGLLDN'")
        }
        return outcome.count
    }
}

class Task10: Task9 {
    override func expected() -> String { "LVZPSTTCZ" }

    override func move(_ num: Int, _ from: Int, _ to: Int) {
        cargo[to-1].append(contentsOf: cargo[from-1].suffix(from: cargo[from-1].count-num))
        cargo[from-1] = cargo[from-1].dropLast(num)
    }
}
