#!/usr/bin/swift

import Foundation

guard let first = readLine(), var depth1 = Int(first) else { exit(0) }
guard var second = readLine(), var depth2 = Int(second) else { exit(0) }
guard var third = readLine(), var depth3 = Int(third) else { exit(0) }

var increasedCount = 0
var previousSum = 0
var currentSum = 0
while let line = readLine(), let depth = Int(line) {
    previousSum = depth1 + depth2 + depth3
    currentSum = depth2 + depth3 + depth
    if currentSum > previousSum {
        increasedCount += 1
    }
    
    depth1 = depth2
    depth2 = depth3
    depth3 = depth
}

print(increasedCount)
