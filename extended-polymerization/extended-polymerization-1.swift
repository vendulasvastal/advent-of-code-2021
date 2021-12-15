#!/usr/local/swift

import Foundation

guard var template = readLine() else { exit(0) }

let _ = readLine() // empty line

var map: [String: String] = [:]
var charCounts: [Character: Int] = [:]

while let line = readLine()?.components(separatedBy: " -> ") {
    map[line[0]] = line[1]
}

func expand(_ str: inout String) {
    for i in stride(from: str.count-2, through: 0, by: -1) {
        let start = str.index(str.startIndex, offsetBy: i)
        let end = str.index(str.startIndex, offsetBy: i+1)
        let insertIndex = str.index(str.startIndex, offsetBy: i+1)
        str.insert(contentsOf: map[String(str[start...end])] ?? "", at: insertIndex)
    }
}

for i in (0..<10) {
    expand(&template)
}

template.forEach {
    charCounts[$0] = (charCounts[$0] ?? 0) + 1
}

let counts = charCounts.map { $0.value }
let min = counts.min() ?? 0
let max = counts.max() ?? 0

print(max-min)
