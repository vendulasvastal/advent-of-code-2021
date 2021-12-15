#!/usr/bin/swift

import Foundation

var configuration: [[Int]] = []
while let line = readLine()?.map(String.init).compactMap(Int.init) {
    configuration.append(line)
}

let n = configuration.count

let directions = [
    (0,1),
    (0,-1),
    (1,0),
    (1,1),
    (-1,0),
    (-1,1),
    (1,-1),
    (-1,-1)
]

var count = 0

func flash(i: Int, j: Int) {
    guard configuration[i][j] > 9 else { return }
    count += 1
    configuration[i][j] = 0
    
    for (v,h) in directions {
        guard (0..<n).contains(i+v) && (0..<n).contains(j+h) else { continue }
        if configuration[i+v][j+h] != 0 {
            configuration[i+v][j+h] += 1
        }
        flash(i: i+v, j: j+h)
    }
}

var round = 0
var notInSync = true
while notInSync {
    round += 1
    for i in (0..<n) {
        for j in (0..<n) {
            configuration[i][j] += 1
        }
    }

    count = 0
    for i in (0..<n) {
        for j in (0..<n) {
            flash(i: i, j: j)
        }
    }
    if count == n*n {
        notInSync = false
    }
}

for i in (0..<n) {
    print(configuration[i].map(String.init).joined())
}

print(round)


