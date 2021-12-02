#!/usr/bin/swift

var increasedCount = 0
var previousDepth = Int.max
while let line = readLine(), let depth = Int(line) {
    if depth > previousDepth {
        increasedCount += 1
    }
    previousDepth = depth
}

print(increasedCount)
