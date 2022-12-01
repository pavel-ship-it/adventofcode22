extension Array where Element == Int? {
    func calcCarry() -> [Int] {
        reduce(into: [0]) { partialResult, element in
            if element == nil {
                partialResult.append(0)
            }
            if let element = element {
                partialResult[partialResult.count-1] += element
            }
        }
    }
}

class Task1: Task {
    func calc(_ inputFile: String) -> Int {
        let input = fileDataWithEmptyLines(inputFile).map { Int($0) }
            .calcCarry()
            .max() ?? -1
        return input
    }
}

class Task2: Task1 {
    override func calc(_ inputFile: String) -> Int {
        let input = fileDataWithEmptyLines(inputFile).map { Int($0) }
            .calcCarry()
            .sorted(by: >)
            .prefix(upTo: 3)
            .reduce(0, +)
        return input
    }
}
