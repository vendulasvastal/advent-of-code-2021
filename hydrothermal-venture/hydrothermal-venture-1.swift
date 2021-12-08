#!/usr/bin/swift

import Foundation

var lines: [[[Int]]] = []
var points: [String: Int] = [:]
var sum = 0

while let read = readLine() {
    let line = read.components(separatedBy: " -> ").map { $0.components(separatedBy: ",").compactMap(Int.init) }
    lines.append(line)
}

print(lines)

lines
.forEach {
    var x1 = $0[0][0]
    var y1 = $0[0][1]
    let x2 = $0[1][0]
    let y2 = $0[1][1]
    print(x1, y1, x2, y2)
    let moveX = (((x2 - x1) <= 0) ? (((x2 - x1) == 0) ? 0 : -1) : 1)
    let moveY = (((y2 - y1) <= 0) ? (((y2 - y1) == 0) ? 0 : -1) : 1)
    while ((x1 != x2 + moveX) || (y1 !=  y2 + moveY)) {
        let str = [x1,y1].map(String.init).joined(separator: ",")
        let val = points[str] ?? 0
        print(x1, y1)
        if val == 1 { sum += 1 }
        points[str] = val + 1
        x1 += moveX
        y1 += moveY
    }
    print("----------")
}

print(points)

print(sum)
