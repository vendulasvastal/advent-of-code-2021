#!/usr/bin/swift

import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

var numbers: [[Int]] = []

while let line = readLine() {
    let row = line.compactMap { Int(String($0)) }
    numbers.append(row)
}

let rows = numbers.count
let cols = numbers[0].count

var riskLevel = 0

for i in (0..<rows) {
    for j in (0..<cols) {
        let curr = numbers[i][j]
        if i != 0 && numbers[i-1][j] <= curr { continue }
        if j != 0 && numbers[i][j-1] <= curr { continue }
        if i != rows-1 && numbers[i+1][j] <= curr { continue }
        if j != cols-1 && numbers[i][j+1] <= curr { continue }
        riskLevel += (curr+1)
    }
}

print(riskLevel)
