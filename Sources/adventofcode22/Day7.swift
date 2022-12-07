import Foundation

class File {
    var name: String
    var isDir: Bool
    private var _size: Int
    var size: Int {
        get { isDir ? children.map { $0.size }.reduce(0, +) : _size }
        set { _size = newValue }
    }
    var parent: File?
    var children: [File] = []

    init(name: String, isDir: Bool, parent: File?, size: Int = 0) {
        self.name = name
        self.isDir = isDir
        self.parent = parent
        _size = size
    }
}

class Task13: Task {
    func readLog(log: [String]) -> File {
        let root = File(name: "/", isDir: true, parent: nil)
        var current: File = root
        var i = 1
        while i < log.count {
            let line = log[i]
            let comps = line.components(separatedBy: CharacterSet(charactersIn: " "))
            if line.prefix(4) == "$ cd" {
                switch comps[2] {
                case "/":
                    current = root
                case "..":
                    current = current.parent!
                default:
                    current = current.children.first(where: { $0.name == comps[2] })!
                }
            }  else if line == "$ ls" {
                // no op
            } else if line.prefix(4) == "dir " {
                current.children.append(File(name: String(comps[1]), isDir: true, parent: current))
            } else {
                current.children.append(File(name: comps[1], isDir: false, parent: current, size: Int(comps[0])!))
            }
            i+=1
        }
        return root
    }

    func countDirsBelow100K(_ file: File) -> Int {
        var sizes = 0
        if file.isDir {
            sizes += file.children.map { countDirsBelow100K($0) }.reduce(0, +)
            if file.size <= 100000 {
                sizes += file.size
            }
        }
        return sizes
    }

    func calc(_ inputFile: String) -> Int {
        let root = readLog(log: fileData(inputFile))
        return countDirsBelow100K(root)
    }
}

class Task14: Task13 {
    func searchForSmallestEnoughDir(_ file: File, _ needToFree: Int) -> File? {
        if file.isDir {
            var matchingDirs = file.children.compactMap { searchForSmallestEnoughDir($0, needToFree) }
            if file.size > needToFree {
                matchingDirs.append(file)
            }
            return matchingDirs.sorted(by: { $0.size < $1.size } ).first
        }
        return nil
    }

    override func calc(_ inputFile: String) -> Int {
        let root = readLog(log: fileData(inputFile))
        var needToFree = root.size - (70000000 - 30000000)
        return searchForSmallestEnoughDir(root, needToFree)?.size ?? 0
    }
}
