#!/usr/local/swift

import Foundation

var map: [String: String] = [:]
var counts: [String: Int] = [:]

guard var template = readLine() else { exit(0) }

for i in (0..<template.count-1) {
    let start = template.index(template.startIndex, offsetBy: i)
    let end = template.index(template.startIndex, offsetBy: i+1)
    let substring = String(template[start...end])
    counts[substring] = (counts[substring] ?? 0) + 1
}

print(counts)

let _ = readLine() // empty line

while let line = readLine()?.components(separatedBy: " -> ") {
    map[line[0]] = line[1]
}

for _ in (0..<40) {
    var newCounts: [String: Int] = [:]
    for (key, value) in counts {
        guard let first = key.first.map(String.init) else { continue }
        guard let last = key.last.map(String.init) else { continue }
        guard let insert = map[key] else { continue }
        let new1 = [first, insert].joined()
        let new2 = [insert, last].joined()
        
        newCounts[new1] = (newCounts[new1] ?? 0) + value
        newCounts[new2] = (newCounts[new2] ?? 0) + value
    }
    counts = newCounts
}

var charCounts: [String: Int] = [:]
for (key, value) in counts {
    guard let first = key.first.map(String.init) else { continue }
    charCounts[first] = (charCounts[first] ?? 0) + value
}

guard let last = template.last.map(String.init) else { exit(0) }
charCounts[last] = (charCounts[last] ?? 0) + 1

let finalCounts = charCounts.map { $0.1 }
let min = finalCounts.min() ?? 0
let max = finalCounts.max() ?? 0

print(max-min)

