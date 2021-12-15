#!/usr/local/swift

import Foundation

var values: [[Int]] = []
while let line = readLine() {
    line.map {
        let value = Int(String($0))!
        
    }
    for i in ()
    values.append(line.compactMap { Int(String($0)) })
}

let rows = values.count
let cols = values[0].count

for row in (0..<rows) {
    print(values[row])
}

for row in (0..<rows) {
    for col in (0..<cols) {
        if row == 0 && col == 0 { continue }
        let topValue = row == 0 ? Int.max : values[row-1][col]
        let leftValue = col == 0 ? Int.max : values[row][col-1]
        values[row][col] = min(topValue, leftValue) + values[row][col]
    }
}

print(values[rows-1][cols-1])
