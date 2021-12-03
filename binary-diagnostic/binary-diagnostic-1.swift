#!/usr/bin/swift

import Foundation

func update(counts: inout [Int], with binary: String) {
    for (index, value) in binary.enumerated() {
        guard value == "1" else { continue }
        counts[index] += 1
    }
}

guard let line = readLine() else { exit(0) }
var oneCounts: [Int] = .init(repeating: 0, count: line.count)
var total: Int = 1
update(counts: &oneCounts, with: line)

while let line = readLine() {
    total += 1
    update(counts: &oneCounts, with: line)
}

let gammaString = oneCounts
    .map { Double($0) / Double(total) }
    .map { $0 > 0.5 ? "1" : "0" }
    .joined()

let epsilonString = oneCounts
    .map { Double($0) / Double(total) }
    .map { $0 > 0.5 ? "0" : "1" }
    .joined()

guard let gamma = Int(gammaString, radix: 2), let epsilon = Int(epsilonString, radix: 2) else { exit(0) }

print(gamma * epsilon)



    
