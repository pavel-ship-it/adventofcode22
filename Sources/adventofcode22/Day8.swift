class Task15: Task {
    func trace(_ forest: [[Int]], _ range: Range<Int>, _ mapper: (Int)->(Bool)) -> Bool {
        range.map(mapper).filter({ $0 }).count == range.count
    }

    func isVisible(_ forest: [[Int]], _ x: Int, _ y: Int) -> Bool {
        trace(forest, (0..<y), { forest[y][x] > forest[$0][x] }) ||
        trace(forest, (x+1..<forest[0].count), { forest[y][x] > forest[y][$0] }) ||
        trace(forest, (y+1..<forest.count), { forest[y][x] > forest[$0][x] }) ||
        trace(forest, (0..<x), { forest[y][x] > forest[y][$0] })
    }

    func countVisible(_ forest: [[Int]]) -> Int {
        var count = (forest.count - 1) * 2 + (forest[0].count - 1) * 2
        for y in (1..<forest.count - 1) {
            for x in (1..<forest[0].count - 1) {
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

class Task16: Task {
    func scoreView(_ forest: [[Int]], _ checkingSpot: Int, _ range: [Int], _ getter: (Int)->(Int)) -> Int {
        var tallest = 0
        var counter = 0
        for i in range {
            counter += 1
            let t = getter(i)
            if t >= tallest {
                tallest = t
                if tallest >= checkingSpot {
                    break
                }
            }
        }
        return counter
    }

    func scorePatch(_ forest: [[Int]], _ x: Int, _ y: Int) -> Int {
        [scoreView(forest, forest[y][x], Array((0..<y).reversed()), { forest[$0][x] }),
         scoreView(forest, forest[y][x], Array((x+1..<forest[0].count)), { forest[y][$0] }),
         scoreView(forest, forest[y][x], Array((y+1..<forest.count)), { forest[$0][x] }),
         scoreView(forest, forest[y][x], Array((0..<x).reversed()), { forest[y][$0] })]
            .filter { $0 != 0 }.reduce(1, *)
    }

    func countScenicScore(_ forest: [[Int]]) -> Int {
        var score = [[Int]](repeating: [Int](repeating: 0, count: forest[0].count), count: forest.count)
        for y in (1..<forest.count-1) {
            for x in (1..<forest[0].count-1) {
                score[y][x] = scorePatch(forest, x, y)
            }
        }
        return Array(score.joined()).max()!
    }

    func calc(_ inputFile: String) -> Int {
        let forest = fileData(inputFile).map { Array($0).map { Int(String($0))! } }
        return countScenicScore(forest)
    }
}
