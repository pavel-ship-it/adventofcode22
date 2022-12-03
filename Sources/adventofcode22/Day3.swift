import Foundation

extension ClosedRange where Bound == Unicode.Scalar {
    var range: ClosedRange<UInt32>  { lowerBound.value...upperBound.value }
    var scalars: [Unicode.Scalar]   { range.compactMap(Unicode.Scalar.init) }
    var characters: [Character]     { scalars.map(Character.init) }
}

class Task5: Task {
    let chr: [String] = {
        ("a"..."z").characters.map { String($0) } +
        ("A"..."Z").characters.map { String($0) }
    }()

    func find(_ s: String) -> Int {
        let l = Set(s.prefix(upTo: s.index(s.startIndex, offsetBy: s.count/2)))
        let r = Set(s.suffix(from: s.index(s.startIndex, offsetBy: s.count/2)))
        let i = l.intersection(r)
        let p = chr.firstIndex(of: String(i))! + 1
        return p
    }

    func calc(_ inputFile: String) -> Int {

        let out = fileData(inputFile)
            .map { find($0) }
            .reduce(0, +)
        return out
    }
}

extension Array {
    func split(_ len: Int) -> [[Element]] {
        var copy = self
        var out = [[Element]]()
        repeat {
            let pref = Array(copy.prefix(len))
            copy = Array(copy.dropFirst(len))
            out.append(pref)
        } while copy.count != 0
        return out
    }
}

class Task6: Task5 {
    func getBadge(_ str: [String]) -> Int {
        var out = Set<Character>()
        str.forEach { e in
            if out.count == 0 {
                out = Set(Array(e))
            } else {
                out = out.intersection(Set(Array(e)))
            }
        }
        let p = chr.firstIndex(of: String(out.first!))! + 1
        return p
    }

    override func calc(_ inputFile: String) -> Int {
        let out = fileData(inputFile)
            .split(3)
            .map { getBadge($0) }
            .reduce(0, +)
        return out
    }
}
