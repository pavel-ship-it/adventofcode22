import Foundation

enum Hand: String {
    case A, B, C, X, Y, Z

    func points() -> Int {
        switch self {
        case .A, .X: return 1 // Rock
        case .B, .Y: return 2 // Paper
        case .C, .Z: return 3 // Scissors
        }
    }

    func getRightHand(_ outcome: Hand) -> Hand {
        switch outcome {
        case .X: return toLose()
        case .Y: return toDraw()
        case .Z: return toWin()
        default: fatalError("Unexpected combo")
        }
    }

    func toWin() -> Hand {
        ([.A: .Y,
          .B: .Z,
          .C: .X] as [Hand: Hand])[self]!
    }

    func toDraw() -> Hand {
        ([.A: .X,
          .B: .Y,
          .C: .Z] as [Hand: Hand])[self]!
    }

    func toLose() -> Hand {
        ([.A: .Z,
          .B: .X,
          .C: .Y] as [Hand: Hand])[self]!
    }
}

class Task3: Task {
    func outcome(_ l: Hand, _ r: Hand) -> Int {
        var pts = r.points()
        switch (l, r) {
        case (.A, .X), (.B, .Y), (.C, .Z): pts += 3
        case (.A, .Y), (.B, .Z), (.C, .X): pts += 6
        case (.A, .Z), (.B, .X), (.C, .Y): pts += 0
        default: fatalError("Unexpected combo")
        }
        return pts
    }

    func calc(_ inputFile: String) -> Int {
        fileData(inputFile)
            .map { $0.map { String($0) } }
            .map { outcome(Hand(rawValue: $0[0])!, Hand(rawValue: $0[2])!) }
            .reduce(0, +)
    }
}

class Task4: Task3 {
    override func outcome(_ l: Hand, _ r: Hand) -> Int {
        let r = l.getRightHand(r)
        return super.outcome(l, r)
    }
}
