import Foundation
class Task7: Task {
    func calc(_ inputFile: String) -> Int {
        let out = fileData(inputFile)
            .map { $0.components(separatedBy: CharacterSet(charactersIn: "-,")) }
            .map {
                let al = Int($0[0])!
                let ar = Int($0[1])!
                let bl = Int($0[2])!
                let br = Int($0[3])!
                return (al <= bl && ar >= br) || (bl <= al && br >= ar) ? 1 : 0
            }
            .reduce(0, +)
        return out
    }
}

class Task8: Task7 {
    override func calc(_ inputFile: String) -> Int {
        let out = fileData(inputFile)
            .map { $0.components(separatedBy: CharacterSet(charactersIn: "-,")) }
            .map {
                let al = Int($0[0])!
                let ar = Int($0[1])!
                let bl = Int($0[2])!
                let br = Int($0[3])!
                return ar < bl || br < al ? 0 : 1
            }
            .reduce(0, +)
        return out
    }
}
