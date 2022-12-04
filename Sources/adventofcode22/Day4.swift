import Foundation
class Task7: Task {
    func calc(_ inputFile: String) -> Int {
        fileData(inputFile)
            .map { $0.components(separatedBy: CharacterSet(charactersIn: "-,")) }
            .map {
                let al = Int($0[0])!
                let ar = Int($0[1])!
                let bl = Int($0[2])!
                let br = Int($0[3])!
                return (al <= bl && ar >= br) || (bl <= al && br >= ar) ? 1 : 0
            }
            .reduce(0, +)
    }
}

class Task7ToBad: Task {
    func calc(_ inputFile: String) -> Int {
        fileData(inputFile)
            .map { $0.components(separatedBy: CharacterSet(charactersIn: "-,")) }
            .map { (Int($0[0])!, Int($0[1])!, Int($0[2])!, Int($0[3])!) }
            .map { ($0.0 <= $0.2 && $0.1 >= $0.3) || ($0.2 <= $0.0 && $0.3 >= $0.1) ? 1 : 0 } // The line here
            .reduce(0, +)
    }
}

class Task8: Task {
    func calc(_ inputFile: String) -> Int {
        fileData(inputFile)
            .map { $0.components(separatedBy: CharacterSet(charactersIn: "-,")) }
            .map {
                let al = Int($0[0])!
                let ar = Int($0[1])!
                let bl = Int($0[2])!
                let br = Int($0[3])!
                return ar < bl || br < al ? 0 : 1
            }
            .reduce(0, +)
    }
}
