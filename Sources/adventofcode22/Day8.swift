class Task15: Task {
    func trace(_ forest: [[Int]], _ range: Range<Int>, _ mapper: (Int)->(Bool)) -> Bool {
        range.map(mapper).filter({ $0 }).count == range.count
    }

    func isVisible(_ forest: [[Int]], _ x: Int, _ y: Int) -> Bool {
        if trace(forest, (0..<y), { forest[y][x] > forest[$0][x] }) ||
            trace(forest, (x+1..<forest[0].count), { forest[y][x] > forest[y][$0] }) ||
            trace(forest, (y+1..<forest.count), { forest[y][x] > forest[$0][x] }) ||
            trace(forest, (0..<x), { forest[y][x] > forest[y][$0] }) {
            return true
        }
        return false
    }

    func countVisible(_ forest: [[Int]]) -> Int {
        var count = (forest.count-1)*2+(forest[0].count-1)*2
        for y in (1..<forest.count-1) {
            for x in (1..<forest[0].count-1) {
                count += (isVisible(forest, x, y) ? 1 : 0)
            }
        }
        return count
    }

    func calc(_ inputFile: String) -> Int {
        let forest = fileData(inputFile).map { Array($0).map { Int(String($0))! } }
        return countVisible(forest)
    }
}
