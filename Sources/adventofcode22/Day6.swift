class Task11: Task {
    func findPacket(_ data: String, _ packetLen: Int) -> Int {
        let data = Array(data)
        for i in packetLen..<data.count {
            if Set(data[i-packetLen..<i]).count == packetLen {
                return i
            }
        }
        return 0
    }

    func calc(_ inputFile: String) -> Int {
        findPacket(fileData(inputFile)[0], 4)
    }
}

class Task12: Task11 {
//    let test = [
//        "mjqjpqmgbljsphdztnvjfqwrcgsmlb": 19,
//        "bvwbjplbgvbhsrlpgdmjqwftvncz": 23,
//        "nppdvjthqldpwncqszvftbrmjlhg": 23,
//        "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg": 29,
//        "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw": 26,
//    ]

    override func calc(_ inputFile: String) -> Int {
//        for (_, (k, v)) in test.enumerated() {
//            if findPacket(k, 14) != v {
//                print("Test failed in \(k)")
//            }
//        }
        return findPacket(fileData(inputFile)[0], 14)
    }
}
